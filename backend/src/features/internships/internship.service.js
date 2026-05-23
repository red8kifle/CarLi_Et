const { AppError } = require('../../middleware/error.middleware');
const repo = require('./internship.repository');
const authRepo = require('../auth/auth.repository');

const getAllInternships = (filters) => {
  return repo.findAll(filters);
};

const getInternshipById = (id) => {
  const internship = repo.findById(id);
  if (!internship) {
    throw new AppError('Internship not found.', 404);
  }
  return internship;
};

const createInternship = (companyUserId, data) => {
  const profile = authRepo.getCompanyProfile(companyUserId);
  const companyName = profile?.company_name || data.company_name || 'Unknown Company';

  if (!data.title || !data.location || !data.type) {
    throw new AppError('title, location, and type are required.', 400);
  }

  const id = repo.create({ ...data, company_id: companyUserId, company_name: companyName });
  return repo.findById(id);
};

const updateInternship = (id, companyUserId, data) => {
  const internship = repo.findById(id);
  if (!internship) {
    throw new AppError('Internship not found.', 404);
  }
  if (internship.company_id !== companyUserId) {
    throw new AppError('You can only update your own internships.', 403);
  }

  repo.update(id, data);
  return repo.findById(id);
};

const deleteInternship = (id, companyUserId) => {
  const internship = repo.findById(id);
  if (!internship) {
    throw new AppError('Internship not found.', 404);
  }
  if (internship.company_id !== companyUserId) {
    throw new AppError('You can only delete your own internships.', 403);
  }
  repo.remove(id);
};

module.exports = {
  getAllInternships,
  getInternshipById,
  createInternship,
  updateInternship,
  deleteInternship,
};
