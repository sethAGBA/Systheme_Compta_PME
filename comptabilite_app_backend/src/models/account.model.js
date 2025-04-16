const mongoose = require('mongoose');

const accountSchema = new mongoose.Schema({
  number: { type: String, required: true, unique: true },
  label: { type: String, required: true },
  userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  createdAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model('Account', accountSchema);