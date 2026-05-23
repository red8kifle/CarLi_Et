const Database = require("better-sqlite3");
const path = require("path");
const { DB_PATH } = require("./constants");

const db = new Database(path.resolve(DB_PATH));

// Enable WAL mode for better performance
db.pragma("journal_mode = WAL");
db.pragma("foreign_keys = ON");

const migrate = () => {
  db.exec(`
    CREATE TABLE IF NOT EXISTS users (
      id          INTEGER PRIMARY KEY AUTOINCREMENT,
      email       TEXT    NOT NULL UNIQUE,
      password    TEXT    NOT NULL,
      role        TEXT    NOT NULL CHECK(role IN ('student', 'company')),
      full_name   TEXT,
      created_at  TEXT    NOT NULL DEFAULT (datetime('now'))
    );

    CREATE TABLE IF NOT EXISTS student_profiles (
      id          INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id     INTEGER NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
      university  TEXT,
      department  TEXT,
      year        INTEGER,
      skills      TEXT,
      bio         TEXT,
      resume_url  TEXT,
      avatar_url  TEXT,
      gpa         TEXT,
      updated_at  TEXT    NOT NULL DEFAULT (datetime('now'))
    );

    CREATE TABLE IF NOT EXISTS company_profiles (
      id           INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id      INTEGER NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
      company_name TEXT    NOT NULL,
      industry     TEXT,
      location     TEXT,
      website      TEXT,
      description  TEXT,
      logo_url     TEXT,
      updated_at   TEXT    NOT NULL DEFAULT (datetime('now'))
    );

    CREATE TABLE IF NOT EXISTS internships (
      id            INTEGER PRIMARY KEY AUTOINCREMENT,
      company_id    INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      title         TEXT    NOT NULL,
      company_name  TEXT    NOT NULL,
      location      TEXT    NOT NULL,
      type          TEXT    NOT NULL,
      description   TEXT,
      requirements  TEXT,
      skills        TEXT,
      deadline      TEXT,
      is_active     INTEGER NOT NULL DEFAULT 1,
      created_at    TEXT    NOT NULL DEFAULT (datetime('now')),
      updated_at    TEXT    NOT NULL DEFAULT (datetime('now'))
    );

    CREATE TABLE IF NOT EXISTS applications (
      id             INTEGER PRIMARY KEY AUTOINCREMENT,
      internship_id  INTEGER NOT NULL REFERENCES internships(id) ON DELETE CASCADE,
      student_id     INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      cover_letter   TEXT,
      status         TEXT    NOT NULL DEFAULT 'pending'
                             CHECK(status IN ('pending', 'accepted', 'rejected')),
      applied_at     TEXT    NOT NULL DEFAULT (datetime('now')),
      updated_at     TEXT    NOT NULL DEFAULT (datetime('now')),
      UNIQUE(internship_id, student_id)
    );
  `);
  console.log("Database migrated successfully.");
};

migrate();

module.exports = db;
