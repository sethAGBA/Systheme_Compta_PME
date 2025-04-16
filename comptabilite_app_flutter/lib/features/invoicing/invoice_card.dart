// // filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/features/invoicing/invoice_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:ComptaFacile/core/theme/invoice_theme.dart';
import 'package:ComptaFacile/features/invoicing/screens/invoice_model.dart';

class InvoiceCard extends StatelessWidget {
  final Facture facture;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onCancel;
  final VoidCallback? onConvert;
  final VoidCallback? onStatusChange;
  final VoidCallback? onTap;
  final VoidCallback? onPdf;

  // const InvoiceCard({
  //   Key? key,
  //   required this.facture,
  //   this.onEdit,
  //   this.onDelete,
  //   this.onCancel,
  //   this.onConvert,
  //   this.onStatusChange,
  //   this.onTap,
  //   this.onPdf,
  // }) : super(key: key);
const InvoiceCard({
    Key? key,
    required this.facture,
    this.onEdit,
    this.onDelete,
    this.onCancel,
    this.onConvert,
    this.onStatusChange,
    this.onTap,
    this.onPdf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(
      symbol: facture.devise ?? 'XOF',
      decimalDigits: 0,
      locale: 'fr_FR',
    );

    print('Rendu InvoiceCard: ${facture.toJson()}');

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: InvoiceTheme.decorations.card.copyWith(
            gradient: InvoiceTheme.colors.cardGradient,
            border: Border.all(
              color: InvoiceTheme.colors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Facture ${facture.numero.isNotEmpty ? facture.numero : "N/A"}',
                    semanticsLabel: 'Numéro de facture ${facture.numero}',
                    style: InvoiceTheme.textStyles.subtitle,
                  ),
                  _buildStatusChip(facture.statut),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    color: InvoiceTheme.colors.primary.withOpacity(0.6),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      facture.clientNom.isNotEmpty ? facture.clientNom : 'Client inconnu',
                      semanticsLabel: 'Client ${facture.clientNom}',
                      style: InvoiceTheme.textStyles.body,
                    ),
                  ),
                ],
              ),
              if (facture.siret != null) ...[
                const SizedBox(height: 8),
                Text(
                  'SIRET: ${facture.siret}',
                  style: InvoiceTheme.textStyles.body.copyWith(fontSize: 12),
                ),
              ],
              if (facture.motifAvoir != null && facture.type == FactureType.avoir) ...[
                const SizedBox(height: 8),
                Text(
                  'Motif: ${facture.motifAvoir}',
                  style: InvoiceTheme.textStyles.body.copyWith(fontSize: 12),
                ),
              ],
              if (facture.validiteDevis != null && facture.type == FactureType.devis) ...[
                const SizedBox(height: 8),
                Text(
                  'Valide jusqu’au: ${DateFormat('dd/MM/yyyy').format(facture.validiteDevis!)}',
                  style: InvoiceTheme.textStyles.body.copyWith(fontSize: 12),
                ),
              ],
              const SizedBox(height: 12),
              _buildTVA(numberFormat),
              const SizedBox(height: 12),
              _buildAgios(numberFormat),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    numberFormat.format(facture.totalTTC),
                    semanticsLabel: 'Montant total ${facture.totalTTC} ${facture.devise ?? "XOF"}',
                    style: InvoiceTheme.textStyles.amount.copyWith(
                      color: facture.type == FactureType.avoir
                          ? InvoiceTheme.colors.error
                          : InvoiceTheme.colors.primary,
                    ),
                  ),
                  _buildActionButtons(),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDateChip(
                    label: 'Émise',
                    date: facture.dateEmission,
                  ),
                  _buildDateChip(
                    label: 'Échéance',
                    date: facture.dateEcheance,
                    isOverdue: facture.dateEcheance.isBefore(DateTime.now()) &&
                        facture.statut != StatutFacture.payee,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildStatusChip(StatutFacture statut) {
    final isPositive = statut == StatutFacture.payee || statut == StatutFacture.brouillon;
    final isNegative = statut == StatutFacture.annulee || statut == StatutFacture.enRetard;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isPositive
            ? InvoiceTheme.colors.success.withOpacity(0.1)
            : isNegative
                ? InvoiceTheme.colors.error.withOpacity(0.1)
                : InvoiceTheme.colors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statut.name.toUpperCase(),
        semanticsLabel: 'Statut ${statut.name}',
        style: InvoiceTheme.textStyles.body.copyWith(
          color: isPositive
              ? InvoiceTheme.colors.success
              : isNegative
                  ? InvoiceTheme.colors.error
                  : InvoiceTheme.colors.warning,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDateChip({
    required String label,
    required DateTime date,
    bool isOverdue = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isOverdue
            ? InvoiceTheme.colors.error.withOpacity(0.1)
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            size: 16,
            color: isOverdue ? InvoiceTheme.colors.error : Colors.grey,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: isOverdue ? InvoiceTheme.colors.error : Colors.grey,
                ),
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(date),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isOverdue ? InvoiceTheme.colors.error : Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTVA(NumberFormat format) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: InvoiceTheme.colors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total TVA',
            style: TextStyle(
              fontSize: 14,
              color: InvoiceTheme.colors.secondary.withOpacity(0.8),
            ),
          ),
          Text(
            format.format(facture.totalTVA),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: InvoiceTheme.colors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgios(NumberFormat format) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: InvoiceTheme.colors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Agios',
            style: TextStyle(
              fontSize: 14,
              color: InvoiceTheme.colors.warning.withOpacity(0.8),
            ),
          ),
          Text(
            format.format(facture.agios),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: facture.agios > 0
                  ? InvoiceTheme.colors.warning
                  : InvoiceTheme.colors.success,
            ),
          ),
        ],
      ),
    );
  }

//   Widget _buildActionButtons() {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         if (onConvert != null && facture.type == FactureType.devis)
//           IconButton(
//             icon: const Icon(Icons.check_circle),
//             color: InvoiceTheme.colors.success,
//             onPressed: onConvert,
//             tooltip: 'Convertir en facture',
//           ),
//         if (onEdit != null)
//           IconButton(
//             icon: const Icon(Icons.edit),
//             color: InvoiceTheme.colors.primary,
//             onPressed: onEdit,
//             tooltip: 'Modifier',
//           ),
//         if (onDelete != null)
//           IconButton(
//             icon: const Icon(Icons.delete),
//             color: InvoiceTheme.colors.error,
//             onPressed: onDelete,
//             tooltip: 'Supprimer',
//           ),
//         if (onCancel != null && facture.statut != StatutFacture.annulee)
//           IconButton(
//             icon: const Icon(Icons.cancel),
//             color: InvoiceTheme.colors.warning,
//             onPressed: onCancel,
//             tooltip: 'Annuler',
//           ),
//         if (onPdf != null)
//           IconButton(
//             icon: const Icon(Icons.picture_as_pdf),
//             color: InvoiceTheme.colors.primary,
//             onPressed: onPdf,
//             tooltip: 'Générer PDF',
//           ),
//         if (onStatusChange != null)
//           IconButton(
//             icon: const Icon(Icons.info),
//             color: Colors.grey,
//             onPressed: onStatusChange,
//             tooltip: 'Changer statut',
//           ),
//       ],
//     );
//   }
// }


Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onConvert != null && facture.type == FactureType.devis)
          IconButton(
            icon: const Icon(Icons.check_circle),
            color: InvoiceTheme.colors.success,
            onPressed: onConvert,
            tooltip: 'Convertir en facture',
          ),
        if (onEdit != null)
          IconButton(
            icon: const Icon(Icons.edit),
            color: InvoiceTheme.colors.primary,
            onPressed: onEdit,
            tooltip: 'Modifier',
          ),
        if (onDelete != null)
          IconButton(
            icon: const Icon(Icons.delete),
            color: InvoiceTheme.colors.error,
            onPressed: onDelete,
            tooltip: 'Supprimer',
          ),
        if (onCancel != null && facture.statut != StatutFacture.annulee)
          IconButton(
            icon: const Icon(Icons.cancel),
            color: InvoiceTheme.colors.warning,
            onPressed: onCancel,
            tooltip: 'Annuler',
          ),
        if (onPdf != null)
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            color: InvoiceTheme.colors.primary,
            onPressed: onPdf,
            tooltip: 'Générer PDF',
          ),
        if (onStatusChange != null)
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            color: InvoiceTheme.colors.secondary,
            onPressed: onStatusChange,
            tooltip: 'Changer statut',
          ),
      ],
    );
  }
}



