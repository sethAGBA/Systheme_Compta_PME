import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/invoice_theme.dart';

class InvoiceCard extends StatelessWidget {
  final Map<String, dynamic> invoice;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onCancel;
  final VoidCallback? onConvert;
  final VoidCallback? onStatusChange;
  final VoidCallback? onTap;

  const InvoiceCard({
    Key? key,
    required this.invoice,
    this.onEdit,
    this.onDelete,
    this.onCancel,
    this.onConvert,
    this.onStatusChange,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('=== Données reçues dans InvoiceCard ===');
  print(JsonEncoder.withIndent('  ').convert(invoice));
  print('=====================================');

    final numberFormat = NumberFormat.currency(
      symbol: 'FCFA',
      decimalDigits: 0,
    );

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(numberFormat),
              const SizedBox(height: 8),
              _buildClientInfo(),
              const SizedBox(height: 8),
              _buildAmounts(numberFormat),
              const SizedBox(height: 8),
              _buildDates(),
              _buildAgios(numberFormat),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(NumberFormat format) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'N° ${invoice['numero'] ?? ''}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildStatusChip(),
      ],
    );
  }

Widget _buildClientInfo() {
  final clientNom = invoice['clientNom']?.toString() ?? 'Client inconnu';
  print('Données client: $clientNom'); // Debug

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.05),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(Icons.person_outline, 
          color: InvoiceTheme.colors.primary.withOpacity(0.5),
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            clientNom,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildAmounts(NumberFormat format) {
    final totalTTC = invoice['totalTTC'] ?? 0.0;
    return Text(
      'Total: ${format.format(totalTTC)}',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: InvoiceTheme.colors.primary,
      ),
    );
  }

  Widget _buildDates() {
    final dateEmission = DateTime.tryParse(invoice['dateEmission'] ?? '');
    final dateEcheance = DateTime.tryParse(invoice['dateEcheance'] ?? '');
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Émise le: ${dateEmission != null ? DateFormat('dd/MM/yyyy').format(dateEmission) : 'N/A'}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          'Échéance: ${dateEcheance != null ? DateFormat('dd/MM/yyyy').format(dateEcheance) : 'N/A'}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildAgios(NumberFormat format) {
    final agios = invoice['agios'];
    if (agios == null || agios <= 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        'Agios: ${format.format(agios)}',
        style: TextStyle(
          fontSize: 14,
          color: InvoiceTheme.colors.error,
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    final status = invoice['statut'] ?? 'brouillon';
    final statusConfig = _getStatusConfig(status);

    return Chip(
      label: Text(
        statusConfig.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: statusConfig.color,
    );
  }

  StatusConfig _getStatusConfig(String status) {
    switch (status) {
      case 'brouillon':
        return StatusConfig('Brouillon', Colors.grey);
      case 'envoyee':
        return StatusConfig('Envoyée', Colors.blue);
      case 'payee':
        return StatusConfig('Payée', Colors.green);
      case 'retard':
        return StatusConfig('En retard', Colors.orange);
      case 'annulee':
        return StatusConfig('Annulée', Colors.red);
      default:
        return StatusConfig(status, Colors.grey);
    }
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (onConvert != null)
          _buildActionButton(
            icon: Icons.transform,
            color: InvoiceTheme.colors.primary,
            onPressed: onConvert,
            tooltip: 'Convertir en facture',
          ),
        if (onEdit != null)
          _buildActionButton(
            icon: Icons.edit,
            color: InvoiceTheme.colors.primary,
            onPressed: onEdit,
            tooltip: 'Modifier',
          ),
        if (onDelete != null)
          _buildActionButton(
            icon: Icons.delete,
            color: InvoiceTheme.colors.error,
            onPressed: onDelete,
            tooltip: 'Supprimer',
          ),
        if (onCancel != null)
          _buildActionButton(
            icon: Icons.cancel,
            color: InvoiceTheme.colors.warning,
            onPressed: onCancel,
            tooltip: 'Annuler',
          ),
        if (onStatusChange != null)
          _buildActionButton(
            icon: Icons.more_vert,
            color: Colors.grey,
            onPressed: onStatusChange,
            tooltip: 'Changer statut',
          ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
    required String tooltip,
  }) {
    return IconButton(
      icon: Icon(icon),
      color: color,
      onPressed: onPressed,
      tooltip: tooltip,
    );
  }
}

class StatusConfig {
  final String label;
  final Color color;

  const StatusConfig(this.label, this.color);
}