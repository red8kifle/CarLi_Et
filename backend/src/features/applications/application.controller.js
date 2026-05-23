const service = require('./application.service');

const getMyApplications = (req, res, next) => {
  try {
    const applications = service.getMyApplications(req.user.id);
    res.status(200).json({ applications });
  } catch (err) {
    next(err);
  }
};

const getApplicants = (req, res, next) => {
  try {
    const applications = service.getApplicantsForInternship(
      Number(req.params.internshipId),
      req.user.id
    );
    res.status(200).json({ applications });
  } catch (err) {
    next(err);
  }
};

const apply = (req, res, next) => {
  try {
    const { internship_id, cover_letter } = req.body;
    if (!internship_id) {
      return res.status(400).json({ message: 'internship_id is required.' });
    }
    const application = service.apply(req.user.id, Number(internship_id), cover_letter);
    res.status(201).json({ application });
  } catch (err) {
    next(err);
  }
};

const updateStatus = (req, res, next) => {
  try {
    const { status } = req.body;
    if (!status) {
      return res.status(400).json({ message: 'status is required.' });
    }
    const application = service.updateStatus(Number(req.params.id), req.user.id, status);
    res.status(200).json({ application });
  } catch (err) {
    next(err);
  }
};

const withdraw = (req, res, next) => {
  try {
    service.withdraw(Number(req.params.id), req.user.id);
    res.status(200).json({ message: 'Application withdrawn successfully.' });
  } catch (err) {
    next(err);
  }
};

module.exports = { getMyApplications, getApplicants, apply, updateStatus, withdraw };
