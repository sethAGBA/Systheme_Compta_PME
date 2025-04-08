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

// Garde getInvoices et updateInvoiceStatus inchangés pour l'instant
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