// //server.js
// const express = require('express');
// const connectDB = require('./config/db');
// const authRoutes = require('./routes/auth.routes');
// const dashboardRoutes = require('./routes/dashboard.routes');
// const accountingRoutes = require('./routes/accounting.routes');
// const invoiceRoutes = require('./routes/invoice.routes');

// const app = express();
// app.use(express.json());
// connectDB();

// app.use('/auth', authRoutes);
// app.use('/dashboard', dashboardRoutes);
// app.use('/accounting', accountingRoutes);
// app.use('/invoices', invoiceRoutes); // Nouvelle ligne
// app.use('/accounts', require('./routes/accounts.routes'));
// const PORT = process.env.PORT || 3000;
// app.listen(PORT, () => console.log(`Serveur démarré sur le port ${PORT}`));



// filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_backend/server.js

const express = require('express');
const connectDB = require('./config/db');
const authRoutes = require('./routes/auth.routes');
const dashboardRoutes = require('./routes/dashboard.routes');
const accountingRoutes = require('./routes/accounting.routes');
const invoiceRoutes = require('./routes/invoice.routes');

const app = express();
app.use(express.json());
app.use('/documents', express.static('documents'));
connectDB();

app.use('/auth', authRoutes);
app.use('/dashboard', dashboardRoutes);
app.use('/accounting', accountingRoutes);
app.use('/invoices', invoiceRoutes);
app.use('/accounts', require('./routes/accounts.routes'));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Serveur démarré sur le port ${PORT}`));