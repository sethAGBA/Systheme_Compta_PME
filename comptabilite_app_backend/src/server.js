const express = require('express');
const connectDB = require('./config/db');
const authRoutes = require('./routes/auth.routes');
const dashboardRoutes = require('./routes/dashboard.routes');
const accountingRoutes = require('./routes/accounting.routes');
const invoiceRoutes = require('./routes/invoice.routes');

const app = express();
app.use(express.json());
connectDB();

app.use('/auth', authRoutes);
app.use('/dashboard', dashboardRoutes);
app.use('/accounting', accountingRoutes);
app.use('/invoices', invoiceRoutes); // Nouvelle ligne

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Serveur démarré sur le port ${PORT}`));