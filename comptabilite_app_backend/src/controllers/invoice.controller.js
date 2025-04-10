//ce fichier est le controller pour la gestion des factures
// Il contient les fonctions pour créer, récupérer et mettre à jour les factures
// Importation des modèles Invoice et JournalEntry
// Il s'appel invoice.controller.js
const Invoice = require('../models/invoice.model');
const JournalEntry = require('../models/journal_entry.model');

exports.createInvoice = async (req, res) => {
  const { number, clientName, amount } = req.body;
  const userId = req.user.userId;

  console.log('Requête createInvoice:', { userId, number, clientName, amount });

  try {
    const invoice = new Invoice({ userId, number, clientName, amount });
    await invoice.save();
    console.log('Facture sauvegardée:', invoice);

    const entry = new JournalEntry({
      userId,
      description: `Facture ${number} pour ${clientName}`,
      debitEntityType: 'Client',
      debitEntityName: clientName,
      creditEntityType: 'Ventes',
      creditEntityName: 'Ventes',
      amount,
    });
    await entry.save();
    console.log('Écriture comptable sauvegardée:', entry);

    res.status(201).json(invoice);
  } catch (err) {
    console.error('Erreur dans createInvoice:', err);
    res.status(500).json({ error: 'Erreur serveur', details: err.message });
  }
};

exports.getInvoices = async (req, res) => {
  const userId = req.user.userId;
  try {
    const invoices = await Invoice.find({ userId });
    res.status(200).json(invoices);
  } catch (err) {
    console.error('Erreur dans getInvoices:', err);
    res.status(500).json({ error: 'Erreur serveur' });
  }
};

exports.updateInvoiceStatus = async (req, res) => {
  const { invoiceId, status } = req.body;
  const userId = req.user.userId;

  try {
    const invoice = await Invoice.findOneAndUpdate(
      { _id: invoiceId, userId },
      { status },
      { new: true }
    );
    if (!invoice) return res.status(404).json({ error: 'Facture non trouvée' });

    if (status === 'paid') {
      const entry = new JournalEntry({
        userId,
        description: `Paiement facture ${invoice.number}`,
        debitEntityType: 'Banque',
        debitEntityName: 'Banque Populaire',
        creditEntityType: 'Client',
        creditEntityName: invoice.clientName,
        amount: invoice.amount,
      });
      await entry.save();
    }

    res.status(200).json(invoice);
  } catch (err) {
    console.error('Erreur dans updateInvoiceStatus:', err);
    res.status(500).json({ error: 'Erreur serveur' });
  }
};

// Nouvelle méthode : Supprimer une facture
exports.deleteInvoice = async (req, res) => {
  const invoiceId = req.params.id;
  const userId = req.user.userId;

  console.log('Requête deleteInvoice:', { invoiceId, userId });

  try {
    const invoice = await Invoice.findOneAndDelete({ _id: invoiceId, userId });
    if (!invoice) {
      return res.status(404).json({ error: 'Facture non trouvée' });
    }
    console.log('Facture supprimée:', invoice);

    // Optionnel : Supprimer ou ajuster les écritures comptables associées
    // await JournalEntry.deleteOne({ description: `Facture ${invoice.number} pour ${invoice.clientName}` });

    res.status(200).json({ message: 'Facture supprimée avec succès' });
  } catch (err) {
    console.error('Erreur dans deleteInvoice:', err);
    res.status(500).json({ error: 'Erreur serveur', details: err.message });
  }
};

// Nouvelle méthode : Mettre à jour une facture
exports.updateInvoice = async (req, res) => {
  const invoiceId = req.params.id;
  const userId = req.user.userId;
  const { number, clientName, amount } = req.body;

  console.log('Requête updateInvoice:', { invoiceId, userId, number, clientName, amount });

  try {
    const invoice = await Invoice.findOneAndUpdate(
      { _id: invoiceId, userId },
      { number, clientName, amount },
      { new: true }
    );
    if (!invoice) {
      return res.status(404).json({ error: 'Facture non trouvée' });
    }
    console.log('Facture mise à jour:', invoice);

    // Optionnel : Mettre à jour l’écriture comptable associée
    await JournalEntry.updateOne(
      { description: `Facture ${invoice.number} pour ${invoice.clientName}` },
      {
        description: `Facture ${number} pour ${clientName}`,
        debitEntityName: clientName,
        amount,
      }
    );

    res.status(200).json(invoice);
  } catch (err) {
    console.error('Erreur dans updateInvoice:', err);
    res.status(500).json({ error: 'Erreur serveur', details: err.message });
  }
};