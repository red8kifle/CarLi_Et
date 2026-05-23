const authService = require('./auth.service');

const signup = async (req, res, next) => {
  try {
    const { email, password, role, full_name, company_name } = req.body;

    if (!email || !password || !role) {
      return res.status(400).json({ message: 'email, password, and role are required.' });
    }
    if (!['student', 'company'].includes(role)) {
      return res.status(400).json({ message: 'role must be "student" or "company".' });
    }
    if (password.length < 6) {
      return res.status(400).json({ message: 'Password must be at least 6 characters.' });
    }

    const result = await authService.signup(email, password, role, full_name, company_name);
    res.status(201).json(result);
  } catch (err) {
    next(err);
  }
};

const login = async (req, res, next) => {
  try {
    const { email, password, role } = req.body;

    if (!email || !password || !role) {
      return res.status(400).json({ message: 'email, password, and role are required.' });
    }

    const result = await authService.login(email, password, role);
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
};

const deleteAccount = async (req, res, next) => {
  try {
    await authService.deleteAccount(req.user.id);
    res.status(200).json({ message: 'Account deleted successfully.' });
  } catch (err) {
    next(err);
  }
};

const getMe = (req, res) => {
  res.status(200).json({ user: req.user });
};

module.exports = { signup, login, deleteAccount, getMe };
