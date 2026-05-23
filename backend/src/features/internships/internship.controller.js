const service = require('./internship.service');

const getAll = (req, res, next) => {
  try {
    const { search, location, type } = req.query;
    const internships = service.getAllInternships({ search, location, type });
    res.status(200).json({ internships });
  } catch (err) {
    next(err);
  }
};

const getMyInternships = (req, res, next) => {
  try {
    const internships = service.getAllInternships({ company_id: req.user.id });
    res.status(200).json({ internships });
  } catch (err) {
    next(err);
  }
};

const getById = (req, res, next) => {
  try {
    const internship = service.getInternshipById(Number(req.params.id));
    res.status(200).json({ internship });
  } catch (err) {
    next(err);
  }
};

const create = (req, res, next) => {
  try {
    const internship = service.createInternship(req.user.id, req.body);
    res.status(201).json({ internship });
  } catch (err) {
    next(err);
  }
};

const update = (req, res, next) => {
  try {
    const internship = service.updateInternship(Number(req.params.id), req.user.id, req.body);
    res.status(200).json({ internship });
  } catch (err) {
    next(err);
  }
};

const remove = (req, res, next) => {
  try {
    service.deleteInternship(Number(req.params.id), req.user.id);
    res.status(200).json({ message: 'Internship deleted successfully.' });
  } catch (err) {
    next(err);
  }
};

module.exports = { getAll, getMyInternships, getById, create, update, remove };
