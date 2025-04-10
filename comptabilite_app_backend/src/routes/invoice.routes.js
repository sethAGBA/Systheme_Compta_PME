//invoice.routes.js
// const express = require('express');
// const router = express.Router();
// const invoiceController = require('../controllers/invoice.controller');
// const authMiddleware = require('../middlewares/auth.middleware');

// router.post('/', authMiddleware, invoiceController.createInvoice);
// router.get('/', authMiddleware, invoiceController.getInvoices);
// router.put('/status', authMiddleware, invoiceController.updateInvoiceStatus);

// module.exports = router;

const express = require('express');
const router = express.Router();
const invoiceController = require('../controllers/invoice.controller');
const authMiddleware = require('../middlewares/auth.middleware');

router.post('/', authMiddleware, invoiceController.createInvoice);
router.get('/', authMiddleware, invoiceController.getInvoices);
router.put('/status', authMiddleware, invoiceController.updateInvoiceStatus);
router.delete('/:id', authMiddleware, invoiceController.deleteInvoice); // Nouvelle route DELETE
router.put('/:id', authMiddleware, invoiceController.updateInvoice);    // Nouvelle route PUT

module.exports = router;