const express = require('express');
const router = express.Router();
const controller = require('./internship.controller');
const { authenticate } = require('../../middleware/auth.middleware');
const { requireCompany } = require('../../middleware/role.middleware');

// GET  /internships           — public: browse all active internships (students + guests)
router.get('/', controller.getAll);

// GET  /internships/mine      — company only: get their own posted internships
router.get('/mine', authenticate, requireCompany, controller.getMyInternships);

// GET  /internships/:id       — public: view a single internship
router.get('/:id', controller.getById);

// POST /internships           — company only: create a new internship
router.post('/', authenticate, requireCompany, controller.create);

// PUT  /internships/:id       — company only: update their own internship
router.put('/:id', authenticate, requireCompany, controller.update);

// DELETE /internships/:id     — company only: delete their own internship
router.delete('/:id', authenticate, requireCompany, controller.remove);

module.exports = router;
