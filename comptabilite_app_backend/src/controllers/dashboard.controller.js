// ce fichier s'appel dashboard.controller.js
const Invoice = require('../models/invoice.model');
const JournalEntry = require('../models/journal_entry.model');

exports.getDashboardData = async (req, res) => {
  const userId = req.user.userId;

  try {
    const invoices = await Invoice.find({ userId });
    const entries = await JournalEntry.find({ userId });

    const revenue = invoices
      .filter((inv) => inv.status === 'paid')
      .reduce((sum, inv) => sum + inv.amount, 0);

    const unpaidInvoices = invoices.filter((inv) => inv.status === 'unpaid').length;

    // Calcul du solde total basé sur les écritures (banques uniquement pour simplifier)
    const totalBalance = entries.reduce((balance, entry) => {
      if (entry.debitEntityType === 'Banque') {
        return balance - entry.amount; // Débit réduit le solde
      }
      if (entry.creditEntityType === 'Banque') {
        return balance + entry.amount; // Crédit augmente le solde
      }
      return balance;
    }, 0); // Solde initial à 0 (à ajuster si tu veux un solde de départ)

    res.status(200).json({
      revenue,
      unpaidInvoices,
      totalBalance,
    });
  } catch (err) {
    res.status(500).json({ error: 'Erreur serveur' });
  }
};