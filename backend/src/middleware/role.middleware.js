const { ROLES } = require('../config/constants');

const requireRole = (...allowedRoles) => {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ message: 'Not authenticated.' });
    }

    if (!allowedRoles.includes(req.user.role)) {
      return res.status(403).json({
        message: `Access denied. This route is only for: ${allowedRoles.join(', ')}.`,
      });
    }

    next();
  };
};

const requireStudent = requireRole(ROLES.STUDENT);
const requireCompany = requireRole(ROLES.COMPANY);

module.exports = { requireRole, requireStudent, requireCompany };
