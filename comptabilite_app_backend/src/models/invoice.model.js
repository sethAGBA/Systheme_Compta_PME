// This file defines the Invoice model for the MongoDB database using Mongoose.
// It includes fields such as userId, number, clientName, amount, status, and createdAt.
// The userId field references the User model to associate the invoice with a specific user.
//le nom est invoice.model.js
// const mongoose = require('mongoose');

// const invoiceSchema = new mongoose.Schema({
//   userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
//   number: { type: String, required: true },
//   clientName: { type: String, required: true },
//   amount: { type: Number, required: true },
//   status: { type: String, enum: ['paid', 'unpaid'], default: 'unpaid' },
//   createdAt: { type: Date, default: Date.now }, // Déjà présent
// });

// module.exports = mongoose.model('Invoice', invoiceSchema);

// invoice.model.js

// const mongoose = require('mongoose');

// const invoiceSchema = new mongoose.Schema({
//   userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
//   numero: { type: String, required: true },
//   type: { type: String, enum: ['standard', 'recurrente', 'acompte', 'avoir', 'devis'], required: true },
//   statut: { type: String, enum: ['brouillon', 'envoyee', 'payee', 'annulee', 'en_attente', 'accepte', 'refuse'], default: 'brouillon' },
//   clientNom: { type: String, required: true },
//   lignes: [{
//     description: { type: String, required: true },
//     quantite: { type: Number, required: true },
//     prixUnitaire: { type: Number, required: true },
//     tva: { type: Number, default: 0 },
//     remise: { type: Number, default: 0 },
//     rabais: { type: Number, default: 0 },
//     ristourne: { type: Number, default: 0 },
//   }],
//   totalHT: { type: Number, required: true },
//   totalTVA: { type: Number, required: true },
//   totalTTC: { type: Number, required: true },
//   dateEmission: { type: Date, default: Date.now },
//   dateEcheance: { type: Date },
//   frequence: { type: String, enum: ['mensuelle', 'trimestrielle', 'annuelle'] },
//   dateFin: { type: Date },
//   invoiceRef: { type: mongoose.Schema.Types.ObjectId, ref: 'Invoice' },
//   acompte: { type: Number, default: 0 },
//   motifAnnulation: { type: String },
//   createdAt: { type: Date, default: Date.now },
// });

// invoiceSchema.index({ userId: 1, numero: 1 });
// module.exports = mongoose.model('Invoice', invoiceSchema);







// filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_backend/src/models/invoice.model.js

const mongoose = require('mongoose');

const invoiceSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  numero: { type: String, required: true },
  type: {
    type: String,
    enum: ['standard', 'recurrente', 'acompte', 'avoir', 'devis'],
    required: true,
  },
  statut: {
    type: String,
    enum: ['brouillon', 'envoyee', 'payee', 'enRetard', 'annulee', 'enAttente', 'accepte', 'refuse'],
    default: 'brouillon',
  },
  clientNom: { type: String, required: true },
  clientAdresse: { type: String },
  clientTVA: { type: String },
  siret: { type: String },
  clientSiret: { type: String },
  adresseFournisseur: { type: String },
  penalitesRetard: { type: String, default: '5000 FCFA + 2% par mois' },
  lignes: [{
    description: { type: String, required: true },
    quantite: { type: Number, required: true },
    prixUnitaire: { type: Number, required: true },
    tva: { type: Number, default: 0 },
    remise: { type: Number, default: 0 },
    rabais: { type: Number, default: 0 },
    ristourne: { type: Number, default: 0 },
  }],
  fraisLivraison: { type: Number, default: 0 },
  agios: { type: Number, default: 0 },
  acompte: { type: Number, default: 0 },
  devise: { type: String, default: 'XOF' },
  invoiceRef: { type: mongoose.Schema.Types.ObjectId, ref: 'Invoice' },
  motifAnnulation: { type: String },
  frequence: { type: String, enum: ['mensuelle', 'trimestrielle', 'annuelle'] },
  dateFin: { type: Date },
  parentInvoice: { type: mongoose.Schema.Types.ObjectId, ref: 'Invoice' },
  revisionPrix: { type: String },
  motifAvoir: { type: String },
  creditType: { type: String },
  validiteDevis: { type: Date },
  version: { type: Number, default: 1 },
  signature: { type: String },
  dateEmission: { type: Date, default: Date.now },
  dateEcheance: { type: Date },
  createdAt: { type: Date, default: Date.now },
});

invoiceSchema.index({ userId: 1, numero: 1 });
module.exports = mongoose.model('Invoice', invoiceSchema);


// const mongoose = require('mongoose');

// const invoiceSchema = new mongoose.Schema({
//   userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
//   numero: { type: String, required: true },
//   type: {
//     type: String,
//     enum: ['standard', 'recurrente', 'acompte', 'avoir', 'devis'],
//     required: true,
//   },
//   statut: {
//     type: String,
//     enum: ['brouillon', 'envoyee', 'payee', 'enRetard', 'annulee', 'enAttente', 'accepte', 'refuse'],
//     default: 'brouillon',
//   },
//   clientNom: { type: String, required: true },
//   clientAdresse: { type: String },
//   clientTVA: { type: String },
//   clientRccm: { type: String, required: true },
//   siret: { type: String },
//   clientSiret: { type: String },
//   adresseFournisseur: { type: String },
//   penalitesRetard: { type: String, default: '5000 FCFA + 2% par mois' },
//   lignes: [{
//     description: { type: String, required: true },
//     quantite: { type: Number, required: true },
//     prixUnitaire: { type: Number, required: true },
//     tva: { type: Number, default: 0 },
//     remise: { type: Number, default: 0 },
//     rabais: { type: Number, default: 0 },
//     ristourne: { type: Number, default: 0 },
//   }],
//   fraisLivraison: { type: Number, default: 0 },
//   agios: { type: Number, default: 0 },
//   acompte: { type: Number, default: 0 },
//   devise: { type: String, default: 'XOF' },
//   invoiceRef: { type: mongoose.Schema.Types.ObjectId, ref: 'Invoice' },
//   motifAnnulation: { type: String },
//   frequence: { type: String, enum: ['mensuelle', 'trimestrielle', 'annuelle'] },
//   dateFin: { type: Date },
//   parentInvoice: { type: mongoose.Schema.Types.ObjectId, ref: 'Invoice' },
//   revisionPrix: { type: String },
//   motifAvoir: { type: String },
//   creditType: { type: String },
//   validiteDevis: { type: Date },
//   version: { type: Number, default: 1 },
//   signature: { type: String },
//   dateEmission: { type: Date, default: Date.now },
//   dateEcheance: { type: Date },
//   createdAt: { type: Date, default: Date.now },
// });

// invoiceSchema.index({ userId: 1, numero: 1 });
// module.exports = mongoose.model('Invoice', invoiceSchema);
