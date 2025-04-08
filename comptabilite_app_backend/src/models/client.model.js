const mongoose = require('mongoose');

const clientSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  name: { type: String, required: true },
  accountCode: { type: String, default: '411' }, // Compte par défaut pour clients
  contact: { type: String }, // Optionnel
  createdAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model('Client', clientSchema);