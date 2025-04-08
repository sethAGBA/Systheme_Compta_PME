const JournalEntry = require('../models/journal_entry.model');

exports.createEntry = async (req, res) => {
  const { description, debitEntityType, debitEntityName, creditEntityType, creditEntityName, amount } = req.body;
  const userId = req.user.userId;

  try {
    const entry = new JournalEntry({
      userId,
      description,
      debitEntityType,
      debitEntityName,
      creditEntityType,
      creditEntityName,
      amount,
    });
    await entry.save();
    res.status(201).json(entry);
  } catch (err) {
    res.status(500).json({ error: 'Erreur serveur' });
  }
};

exports.getEntries = async (req, res) => {
  const userId = req.user.userId;
  try {
    const entries = await JournalEntry.find({ userId });
    res.status(200).json(entries);
  } catch (err) {
    res.status(500).json({ error: 'Erreur serveur' });
  }
};