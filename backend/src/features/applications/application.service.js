const { AppError } = require("../../middleware/error.middleware");
const { APPLICATION_STATUS } = require("../../config/constants");
const repo = require("./application.repository");
const internshipRepo = require("../internships/internship.repository");

const getMyApplications = (studentId) => {
  return repo.findByStudent(studentId);
};

const getApplicantsForInternship = (internshipId, companyUserId) => {
  const internship = internshipRepo.findById(internshipId);
  if (!internship) {
    throw new AppError("Internship not found.", 404);
  }
  if (internship.company_id !== companyUserId) {
    throw new AppError(
      "You can only view applicants for your own internships.",
      403,
    );
  }
  return repo.findByInternship(internshipId);
};

const apply = (studentId, internshipId, coverLetter) => {
  const internship = internshipRepo.findById(internshipId);
  if (!internship || !internship.is_active) {
    throw new AppError("Internship not found or no longer active.", 404);
  }

  const existing = repo.findByStudentAndInternship(studentId, internshipId);
  if (existing) {
    throw new AppError("You have already applied to this internship.", 409);
  }

  const id = repo.create(studentId, internshipId, coverLetter);
  return repo.findById(id);
};

const updateStatus = (applicationId, companyUserId, status) => {
  const validStatuses = Object.values(APPLICATION_STATUS);
  if (!validStatuses.includes(status)) {
    throw new AppError(
      `status must be one of: ${validStatuses.join(", ")}.`,
      400,
    );
  }

  const application = repo.findById(applicationId);
  if (!application) {
    throw new AppError("Application not found.", 404);
  }

  const internship = internshipRepo.findById(application.internship_id);
  if (internship.company_id !== companyUserId) {
    throw new AppError(
      "You can only update applications for your own internships.",
      403,
    );
  }

  repo.updateStatus(applicationId, status);
  return repo.findById(applicationId);
};

const withdraw = (applicationId, studentId) => {
  const application = repo.findById(applicationId);
  if (!application) {
    throw new AppError("Application not found.", 404);
  }
  if (application.student_id !== studentId) {
    throw new AppError("You can only withdraw your own applications.", 403);
  }
  if (application.status !== APPLICATION_STATUS.PENDING) {
    throw new AppError("You can only withdraw pending applications.", 400);
  }
  repo.remove(applicationId);
};

module.exports = {
  getMyApplications,
  getApplicantsForInternship,
  apply,
  updateStatus,
  withdraw,
};
