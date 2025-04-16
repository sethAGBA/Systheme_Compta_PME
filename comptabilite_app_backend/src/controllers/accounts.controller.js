const Account = require('../models/account.model');

exports.getAccounts = async (req, res) => {
  try {
    const accounts = await Account.find({ userId: req.user.id });
    res.status(200).json(accounts);
  } catch (err) {
    res.status(500).json({ error: 'Erreur lors de la récupération des comptes' });
  }
};

exports.createAccount = async (req, res) => {
  try {
    const { number, label } = req.body;
    const existing = await Account.findOne({ number, userId: req.user.id });
    if (existing) {
      return res.status(400).json({ error: 'Numéro de compte déjà utilisé' });
    }
    const account = new Account({ number, label, userId: req.user.id });
    await account.save();
    res.status(201).json(account);
  } catch (err) {
    res.status(500).json({ error: 'Erreur lors de la création du compte' });
  }
};

exports.updateAccount = async (req, res) => {
  try {
    const { number, label } = req.body;
    const account = await Account.findOneAndUpdate(
      { number: req.params.number, userId: req.user.id },
      { number, label },
      { new: true }
    );
    if (!account) {
      return res.status(404).json({ error: 'Compte non trouvé' });
    }
    res.status(200).json(account);
  } catch (err) {
    res.status(500).json({ error: 'Erreur lors de la mise à jour' });
  }
};

exports.deleteAccount = async (req, res) => {
  try {
    const account = await Account.findOneAndDelete({
      number: req.params.number,
      userId: req.user.id,
    });
    if (!account) {
      return res.status(404).json({ error: 'Compte non trouvé' });
    }
    res.status(200).json({ message: 'Compte supprimé' });
  } catch (err) {
    res.status(500).json({ error: 'Erreur lors de la suppression' });
  }
};