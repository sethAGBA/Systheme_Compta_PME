const express = require('express');
const router = express.Router();
const accountingController = require('../controllers/accounting.controller');
const authMiddleware = require('../middlewares/auth.middleware');

router.post('/entries', authMiddleware, accountingController.createEntry);
router.get('/entries', authMiddleware, accountingController.getEntries);

module.exports = router;