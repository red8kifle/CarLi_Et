const db = require('../../config/db');

const findAll = (filters = {}) => {
  let query = 'SELECT * FROM internships WHERE is_active = 1';
  const params = [];

  if (filters.company_id) {
    query += ' AND company_id = ?';
    params.push(filters.company_id);
  }
  if (filters.location) {
    query += ' AND location LIKE ?';
    params.push(`%${filters.location}%`);
  }
  if (filters.type) {
    query += ' AND type = ?';
    params.push(filters.type);
  }
  if (filters.search) {
    query += ' AND (title LIKE ? OR company_name LIKE ? OR skills LIKE ?)';
    const s = `%${filters.search}%`;
    params.push(s, s, s);
  }

  query += ' ORDER BY created_at DESC';
  return db.prepare(query).all(...params);
};

const findById = (id) => {
  return db.prepare('SELECT * FROM internships WHERE id = ?').get(id);
};

const create = (data) => {
  const result = db.prepare(`
    INSERT INTO internships (company_id, title, company_name, location, type, description, requirements, skills, deadline)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  `).run(
    data.company_id,
    data.title,
    data.company_name,
    data.location,
    data.type,
    data.description,
    data.requirements,
    data.skills,
    data.deadline
  );
  return result.lastInsertRowid;
};

const update = (id, data) => {
  const fields = [];
  const params = [];

  const allowed = ['title', 'location', 'type', 'description', 'requirements', 'skills', 'deadline', 'is_active'];
  for (const key of allowed) {
    if (data[key] !== undefined) {
      fields.push(`${key} = ?`);
      params.push(data[key]);
    }
  }

  if (fields.length === 0) return null;

  fields.push("updated_at = datetime('now')");
  params.push(id);

  return db.prepare(`UPDATE internships SET ${fields.join(', ')} WHERE id = ?`).run(...params);
};

const remove = (id) => {
  return db.prepare('DELETE FROM internships WHERE id = ?').run(id);
};

module.exports = { findAll, findById, create, update, remove };
