const db = require('../../config/db');

const findUserByEmail = (email) => {
  return db.prepare('SELECT * FROM users WHERE email = ?').get(email);
};

const findUserById = (id) => {
  return db.prepare('SELECT id, email, role, full_name, created_at FROM users WHERE id = ?').get(id);
};

const createUser = (email, hashedPassword, role, fullName) => {
  const result = db.prepare(
    'INSERT INTO users (email, password, role, full_name) VALUES (?, ?, ?, ?)'
  ).run(email, hashedPassword, role, fullName);
  return result.lastInsertRowid;
};

const deleteUser = (id) => {
  return db.prepare('DELETE FROM users WHERE id = ?').run(id);
};

const createStudentProfile = (userId) => {
  db.prepare('INSERT OR IGNORE INTO student_profiles (user_id) VALUES (?)').run(userId);
};

const createCompanyProfile = (userId, companyName) => {
  db.prepare(
    'INSERT OR IGNORE INTO company_profiles (user_id, company_name) VALUES (?, ?)'
  ).run(userId, companyName);
};

const getStudentProfile = (userId) => {
  return db.prepare('SELECT * FROM student_profiles WHERE user_id = ?').get(userId);
};

const getCompanyProfile = (userId) => {
  return db.prepare('SELECT * FROM company_profiles WHERE user_id = ?').get(userId);
};

module.exports = {
  findUserByEmail,
  findUserById,
  createUser,
  deleteUser,
  createStudentProfile,
  createCompanyProfile,
  getStudentProfile,
  getCompanyProfile,
};
