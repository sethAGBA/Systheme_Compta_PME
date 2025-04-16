import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LedgerScreen extends StatefulWidget {
  @override
  _LedgerScreenState createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen> {
  final _searchController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grand Livre'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => _generateReport(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: _buildLedgerEntries(),
          ),
          _buildTotals(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                if (_startDate != null)
                  Chip(
                    label: Text(
                      'Du: ${DateFormat('dd/MM/yyyy').format(_startDate!)}',
                    ),
                    onDeleted: () => setState(() => _startDate = null),
                  ),
                if (_endDate != null)
                  Chip(
                    label: Text(
                      'Au: ${DateFormat('dd/MM/yyyy').format(_endDate!)}',
                    ),
                    onDeleted: () => setState(() => _endDate = null),
                  ),
                if (_selectedAccount != null)
                  Chip(
                    label: Text('Compte: $_selectedAccount'),
                    onDeleted: () => setState(() => _selectedAccount = null),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLedgerEntries() {
    return ListView.builder(
      itemCount: 0, // À remplacer par les vraies données
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text('Écriture exemple'),
            subtitle: Text('01/01/2024 - Débit: 1000 FCFA, Crédit: 0 FCFA'),
            trailing: Text('Solde: 1000 FCFA'),
          ),
        );
      },
    );
  }

  Widget _buildTotals() {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
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
            Column(
              children: [
                Text('Solde'),
                Text('0 FCFA', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filtres'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Période'),
              onTap: () async {
                final DateTimeRange? range = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (range != null) {
                  setState(() {
                    _startDate = range.start;
                    _endDate = range.end;
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Compte'),
              onTap: () {
                // Ajouter la sélection de compte
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _generateReport() {
    // Ajouter la logique d'export
  }
}