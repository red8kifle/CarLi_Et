const express = require("express");
const router = express.Router();
const controller = require("./auth.controller");
const { authenticate } = require("../../middleware/auth.middleware");
const {
  requireStudent,
  requireCompany,
} = require("../../middleware/role.middleware");
const multer = require("multer");
const path = require("path");
const fs = require("fs");

// ============================================================
// MULTER SETUP FOR FILE UPLOADS
// ============================================================

// Create upload directories if they don't exist
const uploadDir = "./uploads";
const avatarDir = "./uploads/avatars";
const logoDir = "./uploads/company-logos";
const resumeDir = "./uploads/resumes";

if (!fs.existsSync(uploadDir)) fs.mkdirSync(uploadDir);
if (!fs.existsSync(avatarDir)) fs.mkdirSync(avatarDir, { recursive: true });
if (!fs.existsSync(logoDir)) fs.mkdirSync(logoDir, { recursive: true });
if (!fs.existsSync(resumeDir)) fs.mkdirSync(resumeDir, { recursive: true });

// Avatar upload configuration
const avatarStorage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, avatarDir),
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, "avatar-" + uniqueSuffix + path.extname(file.originalname));
  },
});

const avatarUpload = multer({
  storage: avatarStorage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB limit
  fileFilter: (req, file, cb) => {
    const allowedTypes = /jpeg|jpg|png|gif/;
    const extname = allowedTypes.test(
      path.extname(file.originalname).toLowerCase(),
    );
    const mimetype = allowedTypes.test(file.mimetype);
    if (extname && mimetype) {
      return cb(null, true);
    } else {
      cb(new Error("Only image files are allowed"));
    }
  },
});

// Company Logo upload configuration
const logoStorage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, logoDir),
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, "logo-" + uniqueSuffix + path.extname(file.originalname));
  },
});

const logoUpload = multer({
  storage: logoStorage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB limit
  fileFilter: (req, file, cb) => {
    const allowedTypes = /jpeg|jpg|png|gif/;
    const extname = allowedTypes.test(
      path.extname(file.originalname).toLowerCase(),
    );
    const mimetype = allowedTypes.test(file.mimetype);
    if (extname && mimetype) {
      return cb(null, true);
    } else {
      cb(new Error("Only image files are allowed"));
    }
  },
});

// Resume upload configuration
const resumeStorage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, resumeDir),
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, "resume-" + uniqueSuffix + path.extname(file.originalname));
  },
});

const resumeUpload = multer({
  storage: resumeStorage,
  limits: { fileSize: 10 * 1024 * 1024 }, // 10MB limit
  fileFilter: (req, file, cb) => {
    if (file.mimetype === "application/pdf") {
      return cb(null, true);
    } else {
      cb(new Error("Only PDF files are allowed"));
    }
  },
});

// ============================================================
// UPLOAD ENDPOINTS
// ============================================================

// POST /upload/avatar - Upload student profile image
router.post(
  "/upload/avatar",
  authenticate,
  avatarUpload.single("avatar"),
  async (req, res) => {
    try {
      if (!req.file) {
        return res.status(400).json({ message: "No file uploaded" });
      }
      const avatarUrl = `${req.protocol}://${req.get("host")}/uploads/avatars/${req.file.filename}`;
      const db = require("../../config/db");
      db.prepare(
        "UPDATE student_profiles SET avatar_url = ? WHERE user_id = ?",
      ).run(avatarUrl, req.user.id);
      res.json({ url: avatarUrl });
    } catch (err) {
      res.status(500).json({ message: "Upload failed", error: err.message });
    }
  },
);

// POST /upload/company-logo - Upload company logo
router.post(
  "/upload/company-logo",
  authenticate,
  logoUpload.single("logo"),
  async (req, res) => {
    try {
      if (!req.file) {
        return res.status(400).json({ message: "No file uploaded" });
      }
      const logoUrl = `${req.protocol}://${req.get("host")}/uploads/company-logos/${req.file.filename}`;
      const db = require("../../config/db");
      db.prepare(
        "UPDATE company_profiles SET logo_url = ? WHERE user_id = ?",
      ).run(logoUrl, req.user.id);
      res.json({ url: logoUrl });
    } catch (err) {
      res.status(500).json({ message: "Upload failed", error: err.message });
    }
  },
);

// POST /upload/resume - Upload student resume
router.post(
  "/upload/resume",
  authenticate,
  resumeUpload.single("resume"),
  async (req, res) => {
    try {
      if (!req.file) {
        return res.status(400).json({ message: "No file uploaded" });
      }
      const resumeUrl = `${req.protocol}://${req.get("host")}/uploads/resumes/${req.file.filename}`;
      const db = require("../../config/db");
      db.prepare(
        "UPDATE student_profiles SET resume_url = ? WHERE user_id = ?",
      ).run(resumeUrl, req.user.id);
      res.json({ url: resumeUrl });
    } catch (err) {
      res.status(500).json({ message: "Upload failed", error: err.message });
    }
  },
);

// ============================================================
// AUTH ROUTES
// ============================================================

// POST /auth/signup
router.post("/signup", controller.signup);

// POST /auth/login
router.post("/login", controller.login);

// GET /auth/me
router.get("/me", authenticate, controller.getMe);

// DELETE /auth/account
router.delete("/account", authenticate, controller.deleteAccount);

// ============================================================
// STUDENT PROFILE ROUTES
// ============================================================

// PUT /auth/profile/student - Update student profile
router.put(
  "/auth/profile/student",
  authenticate,
  requireStudent,
  async (req, res, next) => {
    try {
      const db = require("../../config/db");
      const { university, skills, bio, year, resume_url, avatar_url, gpa } =
        req.body;

      const existing = db
        .prepare("SELECT * FROM student_profiles WHERE user_id = ?")
        .get(req.user.id);

      if (existing) {
        db.prepare(
          `
          UPDATE student_profiles 
          SET university = COALESCE(?, university),
              skills = COALESCE(?, skills),
              bio = COALESCE(?, bio),
              year = COALESCE(?, year),
              resume_url = COALESCE(?, resume_url),
              avatar_url = COALESCE(?, avatar_url),
              gpa = COALESCE(?, gpa),
              updated_at = datetime('now')
          WHERE user_id = ?
        `,
        ).run(
          university,
          skills,
          bio,
          year,
          resume_url,
          avatar_url,
          gpa,
          req.user.id,
        );
      } else {
        db.prepare(
          `
          INSERT INTO student_profiles (user_id, university, skills, bio, year, resume_url, avatar_url, gpa)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        `,
        ).run(
          req.user.id,
          university,
          skills,
          bio,
          year,
          resume_url,
          avatar_url,
          gpa,
        );
      }

      res.status(200).json({ message: "Profile updated successfully" });
    } catch (err) {
      next(err);
    }
  },
);

// GET /auth/profile/student/:userId - Get student profile (for company viewing applicants)
router.get(
  "/auth/profile/student/:userId",
  authenticate,
  requireCompany,
  async (req, res, next) => {
    try {
      const db = require("../../config/db");
      const student = db
        .prepare(
          `
          SELECT u.id, u.email, u.full_name, u.role,
                 sp.university, sp.department, sp.year, sp.skills, sp.bio, sp.resume_url, sp.avatar_url, sp.gpa
          FROM users u
          LEFT JOIN student_profiles sp ON sp.user_id = u.id
          WHERE u.id = ? AND u.role = 'student'
        `,
        )
        .get(req.params.userId);

      if (!student) {
        return res.status(404).json({ message: "Student not found" });
      }

      res.status(200).json(student);
    } catch (err) {
      next(err);
    }
  },
);

// GET /auth/profile/me - Get my full profile
router.get("/auth/profile/me", authenticate, async (req, res, next) => {
  try {
    const db = require("../../config/db");

    if (req.user.role === "student") {
      const profile = db
        .prepare(
          `
          SELECT u.id, u.email, u.full_name, u.role,
                 sp.university, sp.department, sp.year, sp.skills, sp.bio, sp.resume_url, sp.avatar_url, sp.gpa
          FROM users u
          LEFT JOIN student_profiles sp ON sp.user_id = u.id
          WHERE u.id = ?
        `,
        )
        .get(req.user.id);
      res.status(200).json(profile);
    } else if (req.user.role === "company") {
      const profile = db
        .prepare(
          `
          SELECT u.id, u.email, u.full_name, u.role,
                 cp.company_name, cp.industry, cp.location, cp.description, cp.logo_url
          FROM users u
          LEFT JOIN company_profiles cp ON cp.user_id = u.id
          WHERE u.id = ?
        `,
        )
        .get(req.user.id);
      res.status(200).json(profile);
    } else {
      res.status(404).json({ message: "Profile not found" });
    }
  } catch (err) {
    next(err);
  }
});

// ============================================================
// COMPANY PROFILE ROUTES
// ============================================================

// PUT /auth/profile/company - Update company profile
router.put(
  "/auth/profile/company",
  authenticate,
  requireCompany,
  async (req, res, next) => {
    try {
      const db = require("../../config/db");
      const { company_name, industry, location, description, logo_url } =
        req.body;

      const existing = db
        .prepare("SELECT * FROM company_profiles WHERE user_id = ?")
        .get(req.user.id);

      if (existing) {
        db.prepare(
          `
          UPDATE company_profiles 
          SET company_name = COALESCE(?, company_name),
              industry = COALESCE(?, industry),
              location = COALESCE(?, location),
              description = COALESCE(?, description),
              logo_url = COALESCE(?, logo_url),
              updated_at = datetime('now')
          WHERE user_id = ?
        `,
        ).run(
          company_name,
          industry,
          location,
          description,
          logo_url,
          req.user.id,
        );
      } else {
        db.prepare(
          `
          INSERT INTO company_profiles (user_id, company_name, industry, location, description, logo_url)
          VALUES (?, ?, ?, ?, ?, ?)
        `,
        ).run(
          req.user.id,
          company_name,
          industry,
          location,
          description,
          logo_url,
        );
      }

      res.status(200).json({ message: "Profile updated successfully" });
    } catch (err) {
      next(err);
    }
  },
);

module.exports = router;
