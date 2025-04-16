import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  DateTime _selectedDate = DateTime.now();
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
          IconButton(
            icon: Icon(_showDetails ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _showDetails = !_showDetails),
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => _generateReport(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildBalanceTable(),
          ),
          _buildTotals(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Balance au ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SwitchListTile(
              title: Text('Afficher les détails'),
              value: _showDetails,
              onChanged: (value) => setState(() => _showDetails = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Compte')),
            DataColumn(label: Text('Libellé')),
            DataColumn(label: Text('Débit')),
            DataColumn(label: Text('Crédit')),
            DataColumn(label: Text('Solde Débiteur')),
            DataColumn(label: Text('Solde Créditeur')),
          ],
          rows: [], // À remplacer par les vraies données
        ),
      ),
    );
  }

  Widget _buildTotals() {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Total Débit'),
                    Text('0 FCFA', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    Text('Total Crédit'),
                    Text('0 FCFA', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Total Solde Débiteur'),
                    Text('0 FCFA', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    Text('Total Solde Créditeur'),
                    Text('0 FCFA', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  void _generateReport() {
    // Ajouter la logique d'export
  }
}