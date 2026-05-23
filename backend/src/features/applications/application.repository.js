const db = require("../../config/db");

const findByStudent = (studentId) => {
  return db
    .prepare(
      `
    SELECT a.*, i.title as internship_title, i.company_name, i.location, i.type
    FROM applications a
    JOIN internships i ON a.internship_id = i.id
    WHERE a.student_id = ?
    ORDER BY a.applied_at DESC
  `,
    )
    .all(studentId);
};

const findByInternship = (internshipId) => {
  // Get applications with student profile data
  const applications = db
    .prepare(
      `
    SELECT a.*, 
           u.full_name as student_name, 
           u.email as student_email,
           sp.university, 
           sp.year, 
           sp.skills, 
           sp.gpa, 
           sp.resume_url
    FROM applications a
    JOIN users u ON a.student_id = u.id
    LEFT JOIN student_profiles sp ON sp.user_id = u.id
    WHERE a.internship_id = ?
    ORDER BY a.applied_at DESC
  `,
    )
    .all(internshipId);

  return applications;
};

const findById = (id) => {
  return db.prepare("SELECT * FROM applications WHERE id = ?").get(id);
};

const findByStudentAndInternship = (studentId, internshipId) => {
  return db
    .prepare(
      "SELECT * FROM applications WHERE student_id = ? AND internship_id = ?",
    )
    .get(studentId, internshipId);
};

const create = (studentId, internshipId, coverLetter) => {
  const result = db
    .prepare(
      "INSERT INTO applications (student_id, internship_id, cover_letter) VALUES (?, ?, ?)",
    )
    .run(studentId, internshipId, coverLetter);
  return result.lastInsertRowid;
};

const updateStatus = (id, status) => {
  return db
    .prepare(
      "UPDATE applications SET status = ?, updated_at = datetime('now') WHERE id = ?",
    )
    .run(status, id);
};

const remove = (id) => {
  return db.prepare("DELETE FROM applications WHERE id = ?").run(id);
};

module.exports = {
  findByStudent,
  findByInternship,
  findById,
  findByStudentAndInternship,
  create,
  updateStatus,
  remove,
};
