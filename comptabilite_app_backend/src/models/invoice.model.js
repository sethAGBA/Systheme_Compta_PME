// This file defines the Invoice model for the MongoDB database using Mongoose.
// It includes fields such as userId, number, clientName, amount, status, and createdAt.
// The userId field references the User model to associate the invoice with a specific user.
//le nom est invoice.model.js
const mongoose = require('mongoose');

const invoiceSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  number: { type: String, required: true },
  clientName: { type: String, required: true },
  amount: { type: Number, required: true },
  status: { type: String, enum: ['paid', 'unpaid'], default: 'unpaid' },
  createdAt: { type: Date, default: Date.now }, // Déjà présent
});

module.exports = mongoose.model('Invoice', invoiceSchema);