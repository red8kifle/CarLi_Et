const express = require('express');
const router = express.Router();
const controller = require('./application.controller');
const { authenticate } = require('../../middleware/auth.middleware');
const { requireStudent, requireCompany } = require('../../middleware/role.middleware');

// GET  /applications/mine                        — student: view my applications
router.get('/mine', authenticate, requireStudent, controller.getMyApplications);

// GET  /applications/internship/:internshipId    — company: view applicants for their internship
router.get('/internship/:internshipId', authenticate, requireCompany, controller.getApplicants);

// POST /applications                             — student: apply to an internship
router.post('/', authenticate, requireStudent, controller.apply);

// PUT  /applications/:id/status                 — company: accept or reject an application
router.put('/:id/status', authenticate, requireCompany, controller.updateStatus);

// DELETE /applications/:id                      — student: withdraw an application
router.delete('/:id', authenticate, requireStudent, controller.withdraw);

module.exports = router;
