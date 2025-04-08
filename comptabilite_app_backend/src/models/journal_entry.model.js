const mongoose = require('mongoose');

const journalEntrySchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  date: { type: Date, default: Date.now }, // Déjà présent
  description: { type: String, required: true },
  debitEntityType: { type: String, enum: ['Banque', 'Fournisseur', 'Client', 'Ventes'], required: true },
  debitEntityName: { type: String, required: true },
  creditEntityType: { type: String, enum: ['Banque', 'Fournisseur', 'Client', 'Ventes'], required: true },
  creditEntityName: { type: String, required: true },
  amount: { type: Number, required: true },
});

module.exports = mongoose.model('JournalEntry', journalEntrySchema);