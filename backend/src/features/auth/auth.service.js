const bcrypt = require('bcryptjs');
const { generateToken } = require('../../config/jwt');
const { AppError } = require('../../middleware/error.middleware');
const repo = require('./auth.repository');

const signup = async (email, password, role, fullName, companyName) => {
  const existing = repo.findUserByEmail(email);
  if (existing) {
    throw new AppError('An account with this email already exists.', 409);
  }

  const hashedPassword = await bcrypt.hash(password, 10);
  const userId = repo.createUser(email, hashedPassword, role, fullName);

  if (role === 'student') {
    repo.createStudentProfile(userId);
  } else if (role === 'company') {
    repo.createCompanyProfile(userId, companyName || fullName);
  }

  const token = generateToken({ id: userId, email, role });
  return { token, user: { id: userId, email, role, full_name: fullName } };
};

const login = async (email, password, role) => {
  const user = repo.findUserByEmail(email);
  if (!user) {
    throw new AppError('Invalid email or password.', 401);
  }

  if (user.role !== role) {
    throw new AppError(`This account is not registered as a ${role}.`, 403);
  }

  const isValid = await bcrypt.compare(password, user.password);
  if (!isValid) {
    throw new AppError('Invalid email or password.', 401);
  }

  let profile = null;
  if (role === 'student') {
    profile = repo.getStudentProfile(user.id);
  } else if (role === 'company') {
    profile = repo.getCompanyProfile(user.id);
  }

  const token = generateToken({ id: user.id, email: user.email, role: user.role });
  return {
    token,
    user: { id: user.id, email: user.email, role: user.role, full_name: user.full_name },
    profile,
  };
};

const deleteAccount = (userId) => {
  const user = repo.findUserById(userId);
  if (!user) {
    throw new AppError('User not found.', 404);
  }
  repo.deleteUser(userId);
};

module.exports = { signup, login, deleteAccount };
