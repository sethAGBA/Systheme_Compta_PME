// // // // // // filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/features/invoicing/screens/invoice_screen.dart

// // // // import 'package:ComptaFacile/core/constants/strings.dart';
// // // // // import 'package:ComptaFacile/core/strings.dart';
// // // // import 'package:ComptaFacile/core/theme/invoice_theme.dart';
// // // // import 'package:ComptaFacile/features/invoicing/providers/invoice_provider.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:provider/provider.dart';
// // // // import 'package:intl/intl.dart';
// // // // import 'package:ComptaFacile/features/invoicing/screens/invoice_model.dart';
// // // // import 'package:ComptaFacile/features/invoicing/invoice_card.dart';
// // // // import 'package:google_fonts/google_fonts.dart';
// // // // import 'package:flutter_animate/flutter_animate.dart';

// // // // extension StringExtension on String {
// // // //   String capitalize() {
// // // //     if (isEmpty) return this;
// // // //     return '${this[0].toUpperCase()}${substring(1)}';
// // // //   }
// // // // }

// // // // class InvoiceScreen extends StatelessWidget {
// // // //   const InvoiceScreen({Key? key}) : super(key: key);

// // // //   Widget _buildInvoiceLineFields(
// // // //       List<LigneFacture> lignes, int index, StateSetter setState, BuildContext context) {
// // // //     final ligne = lignes[index];
// // // //     final descriptionController = TextEditingController(text: ligne.description);
// // // //     final quantiteController = TextEditingController(text: ligne.quantite.toString());
// // // //     final prixUnitaireController = TextEditingController(text: ligne.prixUnitaire.toString());
// // // //     final tvaController = TextEditingController(text: ligne.tva.toString());
// // // //     final remiseController = TextEditingController(text: ligne.remise.toString());

// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // // //       child: Column(
// // // //         children: [
// // // //           TextField(
// // // //             controller: descriptionController,
// // // //             decoration: InputDecoration(
// // // //               labelText: 'Description*',
// // // //               labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //               border: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(12),
// // // //               ),
// // // //               filled: true,
// // // //               fillColor: Colors.grey.shade100,
// // // //             ),
// // // //             style: GoogleFonts.poppins(),
// // // //             onChanged: (value) => ligne.description = value,
// // // //           ),
// // // //           const SizedBox(height: 12),
// // // //           TextField(
// // // //             controller: quantiteController,
// // // //             decoration: InputDecoration(
// // // //               labelText: 'Quantité*',
// // // //               labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //               border: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(12),
// // // //               ),
// // // //               filled: true,
// // // //               fillColor: Colors.grey.shade100,
// // // //             ),
// // // //             style: GoogleFonts.poppins(),
// // // //             keyboardType: TextInputType.number,
// // // //             onChanged: (value) => ligne.quantite = int.tryParse(value) ?? 1,
// // // //           ),
// // // //           const SizedBox(height: 12),
// // // //           TextField(
// // // //             controller: prixUnitaireController,
// // // //             decoration: InputDecoration(
// // // //               labelText: 'Prix Unitaire*',
// // // //               labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //               border: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(12),
// // // //               ),
// // // //               filled: true,
// // // //               fillColor: Colors.grey.shade100,
// // // //             ),
// // // //             style: GoogleFonts.poppins(),
// // // //             keyboardType: TextInputType.number,
// // // //             onChanged: (value) => ligne.prixUnitaire = double.tryParse(value) ?? 0,
// // // //           ),
// // // //           const SizedBox(height: 12),
// // // //           TextField(
// // // //             controller: tvaController,
// // // //             decoration: InputDecoration(
// // // //               labelText: 'TVA (%)*',
// // // //               labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //               border: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(12),
// // // //               ),
// // // //               filled: true,
// // // //               fillColor: Colors.grey.shade100,
// // // //             ),
// // // //             style: GoogleFonts.poppins(),
// // // //             keyboardType: TextInputType.number,
// // // //             onChanged: (value) => ligne.tva = double.tryParse(value) ?? 0,
// // // //           ),
// // // //           const SizedBox(height: 12),
// // // //           TextField(
// // // //             controller: remiseController,
// // // //             decoration: InputDecoration(
// // // //               labelText: 'Remise (%)',
// // // //               labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //               border: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(12),
// // // //               ),
// // // //               filled: true,
// // // //               fillColor: Colors.grey.shade100,
// // // //             ),
// // // //             style: GoogleFonts.poppins(),
// // // //             keyboardType: TextInputType.number,
// // // //             onChanged: (value) => ligne.remise = double.tryParse(value) ?? 0,
// // // //           ),
// // // //           const SizedBox(height: 12),
// // // //           TextButton(
// // // //             onPressed: () => setState(() => lignes.removeAt(index)),
// // // //             child: Text(
// // // //               'Supprimer ligne',
// // // //               style: GoogleFonts.poppins(
// // // //                 color: InvoiceTheme.colors.error,
// // // //                 fontWeight: FontWeight.w600,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildInvoiceList(BuildContext context) {
// // // //     return Consumer<InvoiceProvider>(
// // // //       builder: (context, provider, child) {
// // // //         if (provider.isLoading) {
// // // //           return const Center(child: CircularProgressIndicator());
// // // //         }
// // // //         if (provider.error != null) {
// // // //           return Center(child: Text('${Strings.erreurChargement}${provider.error}'));
// // // //         }
// // // //         final invoices = provider.filter == 'Annulées'
// // // //             ? provider.invoices.where((f) => f.statut == StatutFacture.annulee).toList()
// // // //             : provider.filter == 'Récurrentes'
// // // //                 ? provider.invoices.where((f) => f.type == FactureType.recurrente || f.parentInvoice != null).toList()
// // // //                 : provider.invoices;
// // // //         if (invoices.isEmpty) {
// // // //           return const Center(child: Text(Strings.aucuneFacture));
// // // //         }
// // // //         return ListView.builder(
// // // //           padding: const EdgeInsets.all(8),
// // // //           itemCount: invoices.length,
// // // //           itemBuilder: (context, index) {
// // // //             final facture = invoices[index];
// // // //             return InvoiceCard(
// // // //               facture: facture,
// // // //               onConvert: facture.type == FactureType.devis &&
// // // //                       facture.statut != StatutFacture.payee &&
// // // //                       facture.id != null
// // // //                   ? () => provider.convertDevis(facture.id!)
// // // //                   : null,
// // // //               onCancel: facture.statut != StatutFacture.annulee && facture.id != null
// // // //                   ? () => _cancelInvoice(context, facture.id!)
// // // //                   : null,
// // // //               onDelete: facture.id != null &&
// // // //                       facture.statut != StatutFacture.payee &&
// // // //                       facture.statut != StatutFacture.annulee
// // // //                   ? () => _deleteInvoice(context, facture.id!)
// // // //                   : null,
// // // //               onEdit: facture.id != null &&
// // // //                       facture.statut != StatutFacture.payee &&
// // // //                       facture.statut != StatutFacture.annulee
// // // //                   ? () => _editInvoice(context, facture)
// // // //                   : null,
// // // //               onStatusChange: null,
// // // //               onPdf: facture.id != null
// // // //                   ? () async {
// // // //                       try {
// // // //                         final url = await provider.generatePdf(facture.id!);
// // // //                         ScaffoldMessenger.of(context).showSnackBar(
// // // //                           SnackBar(content: Text('${Strings.pdfExporte}$url')),
// // // //                         );
// // // //                       } catch (e) {
// // // //                         ScaffoldMessenger.of(context).showSnackBar(
// // // //                           SnackBar(content: Text('${Strings.erreurExport}$e')),
// // // //                         );
// // // //                       }
// // // //                     }
// // // //                   : null,
// // // //               onTap: () {
// // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // //                   SnackBar(content: Text('Facture ${facture.numero} sélectionnée')),
// // // //                 );
// // // //               },
// // // //             );
// // // //           },
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   Future<void> _cancelInvoice(BuildContext context, String id) async {
// // // //     final motifController = TextEditingController();

// // // //     final confirm = await showDialog<bool>(
// // // //       context: context,
// // // //       builder: (context) => Dialog(
// // // //         backgroundColor: Colors.white,
// // // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.all(16.0),
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               Text(
// // // //                 'Annuler facture',
// // // //                 style: GoogleFonts.poppins(
// // // //                   fontWeight: FontWeight.w600,
// // // //                   color: InvoiceTheme.colors.primary,
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 12),
// // // //               TextField(
// // // //                 controller: motifController,
// // // //                 decoration: InputDecoration(
// // // //                   labelText: 'Motif d’annulation*',
// // // //                   labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                   border: OutlineInputBorder(
// // // //                     borderRadius: BorderRadius.circular(12),
// // // //                   ),
// // // //                   filled: true,
// // // //                   fillColor: Colors.grey.shade100,
// // // //                 ),
// // // //                 style: GoogleFonts.poppins(),
// // // //               ),
// // // //               const SizedBox(height: 16),
// // // //               Row(
// // // //                 mainAxisAlignment: MainAxisAlignment.end,
// // // //                 children: [
// // // //                   TextButton(
// // // //                     onPressed: () => Navigator.pop(context, false),
// // // //                     child: Text(
// // // //                       'Annuler',
// // // //                       style: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                     ),
// // // //                   ),
// // // //                   TextButton(
// // // //                     onPressed: () {
// // // //                       if (motifController.text.isEmpty) {
// // // //                         ScaffoldMessenger.of(context).showSnackBar(
// // // //                           const SnackBar(content: Text('Le motif est requis')),
// // // //                         );
// // // //                         return;
// // // //                       }
// // // //                       Navigator.pop(context, true);
// // // //                     },
// // // //                     child: Text(
// // // //                       'Confirmer',
// // // //                       style: GoogleFonts.poppins(
// // // //                         color: InvoiceTheme.colors.success,
// // // //                         fontWeight: FontWeight.w600,
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );

// // // //     if (confirm == true) {
// // // //       try {
// // // //         await Provider.of<InvoiceProvider>(context, listen: false)
// // // //             .cancelInvoice(id, motifController.text);
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           const SnackBar(content: Text('Facture annulée avec succès')),
// // // //         );
// // // //       } catch (e) {
// // // //         String errorMessage = e.toString();
// // // //         if (errorMessage.contains('Token requis') || errorMessage.contains('Aucun token')) {
// // // //           errorMessage = 'Veuillez vous reconnecter pour annuler la facture.';
// // // //         } else if (errorMessage.contains('payée')) {
// // // //           errorMessage = 'Cette facture est payée et ne peut pas être annulée.';
// // // //         } else if (errorMessage.contains('annulée')) {
// // // //           errorMessage = 'Cette facture est déjà annulée.';
// // // //         } else {
// // // //           errorMessage = '${Strings.erreurReseau}$errorMessage';
// // // //         }
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text(errorMessage)),
// // // //         );
// // // //       }
// // // //     }
// // // //   }

// // // //   Future<void> _deleteInvoice(BuildContext context, String id) async {
// // // //     final confirm = await showDialog<bool>(
// // // //       context: context,
// // // //       builder: (context) => Dialog(
// // // //         backgroundColor: Colors.white,
// // // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.all(16.0),
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               Text(
// // // //                 'Supprimer facture',
// // // //                 style: GoogleFonts.poppins(
// // // //                   fontWeight: FontWeight.w600,
// // // //                   color: InvoiceTheme.colors.primary,
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 12),
// // // //               Text(
// // // //                 'Êtes-vous sûr de vouloir supprimer cette facture ?',
// // // //                 style: GoogleFonts.poppins(),
// // // //               ),
// // // //               const SizedBox(height: 16),
// // // //               Row(
// // // //                 mainAxisAlignment: MainAxisAlignment.end,
// // // //                 children: [
// // // //                   TextButton(
// // // //                     onPressed: () => Navigator.pop(context, false),
// // // //                     child: Text(
// // // //                       'Annuler',
// // // //                       style: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                     ),
// // // //                   ),
// // // //                   TextButton(
// // // //                     onPressed: () => Navigator.pop(context, true),
// // // //                     child: Text(
// // // //                       'Supprimer',
// // // //                       style: GoogleFonts.poppins(
// // // //                         color: InvoiceTheme.colors.error,
// // // //                         fontWeight: FontWeight.w600,
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //     if (confirm == true) {
// // // //       try {
// // // //         await Provider.of<InvoiceProvider>(context, listen: false).deleteInvoice(id);
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           const SnackBar(content: Text('Facture supprimée avec succès')),
// // // //         );
// // // //       } catch (e) {
// // // //         String errorMessage = e.toString();
// // // //         if (errorMessage.contains('payée') || errorMessage.contains('annulée')) {
// // // //           errorMessage = 'Erreur : Facture payée ou annulée ne peut pas être supprimée.';
// // // //         } else {
// // // //           errorMessage = '${Strings.erreurReseau}$errorMessage';
// // // //         }
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text(errorMessage)),
// // // //         );
// // // //       }
// // // //     }
// // // //   }

// // // //   Future<void> _editInvoice(BuildContext context, Facture facture) async {
// // // //     print('Démarrage _editInvoice pour facture: ${facture.numero}');
// // // //     final numeroController = TextEditingController(text: facture.numero);
// // // //     final clientController = TextEditingController(text: facture.clientNom);
// // // //     final siretController = TextEditingController(text: facture.siret);
// // // //     final clientSiretController = TextEditingController(text: facture.clientSiret);
// // // //     final adresseFournisseurController = TextEditingController(text: facture.adresseFournisseur);
// // // //     final penalitesRetardController = TextEditingController(text: facture.penalitesRetard);
// // // //     final deviseController = TextEditingController(text: facture.devise ?? 'XOF');
// // // //     List<LigneFacture> lignes = List.from(facture.lignes);
// // // //     FactureType type = facture.type;
// // // //     String? frequence = facture.frequence;
// // // //     DateTime? dateFin = facture.dateFin;
// // // //     String? invoiceRef = facture.invoiceRef;
// // // //     double acompte = facture.acompte;
// // // //     String? revisionPrix = facture.revisionPrix;
// // // //     String? motifAvoir = facture.motifAvoir;
// // // //     String? creditType = facture.creditType;
// // // //     DateTime? validiteDevis = facture.validiteDevis;
// // // //     String? signature = facture.signature;
// // // //     int currentStep = 0;

// // // //     try {
// // // //       print('Construction du Dialog');
// // // //       final result = await showDialog<Facture>(
// // // //         context: context,
// // // //         barrierDismissible: false,
// // // //         barrierColor: Colors.black.withOpacity(0.5),
// // // //         builder: (context) {
// // // //           print('Rendu du Dialog');
// // // //           return StatefulBuilder(
// // // //             builder: (context, setState) => Dialog(
// // // //               backgroundColor: Colors.white,
// // // //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // // //               child: Container(
// // // //                 width: MediaQuery.of(context).size.width * 0.95,
// // // //                 height: MediaQuery.of(context).size.height * 0.95,
// // // //                 padding: const EdgeInsets.all(16),
// // // //                 child: Column(
// // // //                   children: [
// // // //                     Text(
// // // //                       facture.id == null ? 'Nouvelle facture' : 'Modifier facture',
// // // //                       style: GoogleFonts.poppins(
// // // //                         fontSize: 22,
// // // //                         fontWeight: FontWeight.w600,
// // // //                         color: InvoiceTheme.colors.primary,
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 16),
// // // //                     Expanded(
// // // //                       child: SingleChildScrollView(
// // // //                         physics: const ClampingScrollPhysics(),
// // // //                         child: Column(
// // // //                           mainAxisSize: MainAxisSize.min,
// // // //                           children: [
// // // //                             Stepper(
// // // //                               currentStep: currentStep,
// // // //                               onStepContinue: () {
// // // //                                 if (currentStep < 2) setState(() => currentStep++);
// // // //                               },
// // // //                               onStepCancel: () {
// // // //                                 if (currentStep > 0) setState(() => currentStep--);
// // // //                               },
// // // //                               steps: [
// // // //                                 Step(
// // // //                                   title: Text(
// // // //                                     'Client',
// // // //                                     style: GoogleFonts.poppins(
// // // //                                       color: currentStep == 0
// // // //                                           ? InvoiceTheme.colors.primary
// // // //                                           : Colors.grey.shade600,
// // // //                                       fontWeight: FontWeight.w600,
// // // //                                     ),
// // // //                                   ),
// // // //                                   content: Column(
// // // //                                     children: [
// // // //                                       TextField(
// // // //                                         controller: numeroController,
// // // //                                         decoration: InputDecoration(
// // // //                                           labelText: 'Numéro*',
// // // //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                           border: OutlineInputBorder(
// // // //                                             borderRadius: BorderRadius.circular(12),
// // // //                                           ),
// // // //                                           filled: true,
// // // //                                           fillColor: Colors.grey.shade100,
// // // //                                         ),
// // // //                                         style: GoogleFonts.poppins(),
// // // //                                       ),
// // // //                                       const SizedBox(height: 12),
// // // //                                       TextField(
// // // //                                         controller: clientController,
// // // //                                         decoration: InputDecoration(
// // // //                                           labelText: 'Client*',
// // // //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                           border: OutlineInputBorder(
// // // //                                             borderRadius: BorderRadius.circular(12),
// // // //                                           ),
// // // //                                           filled: true,
// // // //                                           fillColor: Colors.grey.shade100,
// // // //                                         ),
// // // //                                         style: GoogleFonts.poppins(),
// // // //                                       ),
// // // //                                       const SizedBox(height: 12),
// // // //                                       TextField(
// // // //                                         controller: siretController,
// // // //                                         decoration: InputDecoration(
// // // //                                           labelText: 'SIRET Fournisseur*',
// // // //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                           border: OutlineInputBorder(
// // // //                                             borderRadius: BorderRadius.circular(12),
// // // //                                           ),
// // // //                                           filled: true,
// // // //                                           fillColor: Colors.grey.shade100,
// // // //                                         ),
// // // //                                         style: GoogleFonts.poppins(),
// // // //                                       ),
// // // //                                       const SizedBox(height: 12),
// // // //                                       TextField(
// // // //                                         controller: clientSiretController,
// // // //                                         decoration: InputDecoration(
// // // //                                           labelText: 'SIRET Client',
// // // //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                           border: OutlineInputBorder(
// // // //                                             borderRadius: BorderRadius.circular(12),
// // // //                                           ),
// // // //                                           filled: true,
// // // //                                           fillColor: Colors.grey.shade100,
// // // //                                         ),
// // // //                                         style: GoogleFonts.poppins(),
// // // //                                       ),
// // // //                                       const SizedBox(height: 12),
// // // //                                       TextField(
// // // //                                         controller: adresseFournisseurController,
// // // //                                         decoration: InputDecoration(
// // // //                                           labelText: 'Adresse Fournisseur*',
// // // //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                           border: OutlineInputBorder(
// // // //                                             borderRadius: BorderRadius.circular(12),
// // // //                                           ),
// // // //                                           filled: true,
// // // //                                           fillColor: Colors.grey.shade100,
// // // //                                         ),
// // // //                                         style: GoogleFonts.poppins(),
// // // //                                       ),
// // // //                                       const SizedBox(height: 12),
// // // //                                       TextField(
// // // //                                         controller: penalitesRetardController,
// // // //                                         decoration: InputDecoration(
// // // //                                           labelText: 'Pénalités de retard*',
// // // //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                           border: OutlineInputBorder(
// // // //                                             borderRadius: BorderRadius.circular(12),
// // // //                                           ),
// // // //                                           filled: true,
// // // //                                           fillColor: Colors.grey.shade100,
// // // //                                         ),
// // // //                                         style: GoogleFonts.poppins(),
// // // //                                       ),
// // // //                                       const SizedBox(height: 12),
// // // //                                       DropdownButtonFormField<String>(
// // // //                                         value: deviseController.text.isEmpty ? 'XOF' : deviseController.text,
// // // //                                         items: ['XOF', 'EUR', 'USD', 'XAF']
// // // //                                             .map((d) => DropdownMenuItem(value: d, child: Text(d, style: GoogleFonts.poppins())))
// // // //                                             .toList(),
// // // //                                         onChanged: (v) => setState(() => deviseController.text = v!),
// // // //                                         decoration: InputDecoration(
// // // //                                           labelText: 'Devise*',
// // // //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                           border: OutlineInputBorder(
// // // //                                             borderRadius: BorderRadius.circular(12),
// // // //                                           ),
// // // //                                           filled: true,
// // // //                                           fillColor: Colors.grey.shade100,
// // // //                                         ),
// // // //                                         style: GoogleFonts.poppins(),
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                 ),
// // // //                                 Step(
// // // //                                   title: Text(
// // // //                                     'Lignes',
// // // //                                     style: GoogleFonts.poppins(
// // // //                                       color: currentStep == 1
// // // //                                           ? InvoiceTheme.colors.primary
// // // //                                           : Colors.grey.shade600,
// // // //                                       fontWeight: FontWeight.w600,
// // // //                                     ),
// // // //                                   ),
// // // //                                   content: Column(
// // // //                                     children: [
// // // //                                       ListView.builder(
// // // //                                         shrinkWrap: true,
// // // //                                         physics: const NeverScrollableScrollPhysics(),
// // // //                                         itemCount: lignes.length,
// // // //                                         itemBuilder: (context, index) {
// // // //                                           return _buildInvoiceLineFields(lignes, index, setState, context);
// // // //                                         },
// // // //                                       ),
// // // //                                       const SizedBox(height: 12),
// // // //                                       ElevatedButton(
// // // //                                         onPressed: () => setState(() => lignes.add(LigneFacture(
// // // //                                               description: '',
// // // //                                               quantite: 1,
// // // //                                               prixUnitaire: 0,
// // // //                                               tva: 0,
// // // //                                               remise: 0,
// // // //                                             ))),
// // // //                                         style: ElevatedButton.styleFrom(
// // // //                                           backgroundColor: InvoiceTheme.colors.secondary,
// // // //                                           shape: RoundedRectangleBorder(
// // // //                                             borderRadius: BorderRadius.circular(12),
// // // //                                           ),
// // // //                                         ),
// // // //                                         child: Text(
// // // //                                           'Ajouter ligne',
// // // //                                           style: GoogleFonts.poppins(
// // // //                                             color: Colors.white,
// // // //                                             fontWeight: FontWeight.w600,
// // // //                                           ),
// // // //                                         ),
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                 ),
// // // //                                 Step(
// // // //                                   title: Text(
// // // //                                     'Options',
// // // //                                     style: GoogleFonts.poppins(
// // // //                                       color: currentStep == 2
// // // //                                           ? InvoiceTheme.colors.primary
// // // //                                           : Colors.grey.shade600,
// // // //                                       fontWeight: FontWeight.w600,
// // // //                                     ),
// // // //                                   ),
// // // //                                   content: Column(
// // // //                                     children: [
// // // //                                       DropdownButtonFormField<FactureType>(
// // // //                                         value: type,
// // // //                                         items: FactureType.values
// // // //                                             .map((t) => DropdownMenuItem(
// // // //                                                   value: t,
// // // //                                                   child: Text(
// // // //                                                     t.toString().split('.').last.capitalize(),
// // // //                                                     style: GoogleFonts.poppins(),
// // // //                                                   ),
// // // //                                                 ))
// // // //                                             .toList(),
// // // //                                         onChanged: (v) => setState(() => type = v!),
// // // //                                         decoration: InputDecoration(
// // // //                                           labelText: 'Type*',
// // // //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                           border: OutlineInputBorder(
// // // //                                             borderRadius: BorderRadius.circular(12),
// // // //                                           ),
// // // //                                           filled: true,
// // // //                                           fillColor: Colors.grey.shade100,
// // // //                                         ),
// // // //                                         style: GoogleFonts.poppins(),
// // // //                                       ),
// // // //                                       const SizedBox(height: 12),
// // // //                                       if (type == FactureType.recurrente) ...[
// // // //                                         TextField(
// // // //                                           onChanged: (v) => frequence = v,
// // // //                                           decoration: InputDecoration(
// // // //                                             labelText: 'Fréquence* (mensuelle, trimestrielle, annuelle)',
// // // //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                             border: OutlineInputBorder(
// // // //                                               borderRadius: BorderRadius.circular(12),
// // // //                                             ),
// // // //                                             filled: true,
// // // //                                             fillColor: Colors.grey.shade100,
// // // //                                           ),
// // // //                                           style: GoogleFonts.poppins(),
// // // //                                           controller: TextEditingController(text: frequence),
// // // //                                         ),
// // // //                                         const SizedBox(height: 12),
// // // //                                         TextField(
// // // //                                           onChanged: (v) => revisionPrix = v,
// // // //                                           decoration: InputDecoration(
// // // //                                             labelText: 'Révision des prix (ex. +2%/an)',
// // // //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                             border: OutlineInputBorder(
// // // //                                               borderRadius: BorderRadius.circular(12),
// // // //                                             ),
// // // //                                             filled: true,
// // // //                                             fillColor: Colors.grey.shade100,
// // // //                                           ),
// // // //                                           style: GoogleFonts.poppins(),
// // // //                                           controller: TextEditingController(text: revisionPrix),
// // // //                                         ),
// // // //                                         const SizedBox(height: 12),
// // // //                                         ElevatedButton(
// // // //                                           onPressed: () async {
// // // //                                             dateFin = await showDatePicker(
// // // //                                               context: context,
// // // //                                               initialDate: dateFin ?? DateTime.now(),
// // // //                                               firstDate: DateTime.now(),
// // // //                                               lastDate: DateTime(2030),
// // // //                                             );
// // // //                                             setState(() {});
// // // //                                           },
// // // //                                           style: ElevatedButton.styleFrom(
// // // //                                             backgroundColor: InvoiceTheme.colors.primary,
// // // //                                             shape: RoundedRectangleBorder(
// // // //                                               borderRadius: BorderRadius.circular(12),
// // // //                                             ),
// // // //                                           ),
// // // //                                           child: Text(
// // // //                                             'Date de fin*: ${dateFin != null ? DateFormat('dd/MM/yyyy').format(dateFin!) : "Non défini"}',
// // // //                                             style: GoogleFonts.poppins(
// // // //                                               color: Colors.white,
// // // //                                               fontWeight: FontWeight.w600,
// // // //                                             ),
// // // //                                           ),
// // // //                                         ),
// // // //                                       ],
// // // //                                       if (type == FactureType.acompte || type == FactureType.avoir) ...[
// // // //                                         const SizedBox(height: 12),
// // // //                                         TextField(
// // // //                                           onChanged: (v) => invoiceRef = v,
// // // //                                           decoration: InputDecoration(
// // // //                                             labelText: 'Référence facture (ID)*',
// // // //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                             border: OutlineInputBorder(
// // // //                                               borderRadius: BorderRadius.circular(12),
// // // //                                             ),
// // // //                                             filled: true,
// // // //                                             fillColor: Colors.grey.shade100,
// // // //                                           ),
// // // //                                           style: GoogleFonts.poppins(),
// // // //                                           controller: TextEditingController(text: invoiceRef),
// // // //                                         ),
// // // //                                       ],
// // // //                                       if (type == FactureType.acompte) ...[
// // // //                                         const SizedBox(height: 12),
// // // //                                         TextField(
// // // //                                           onChanged: (v) => acompte = double.tryParse(v) ?? 0,
// // // //                                           decoration: InputDecoration(
// // // //                                             labelText: 'Montant acompte*',
// // // //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                             border: OutlineInputBorder(
// // // //                                               borderRadius: BorderRadius.circular(12),
// // // //                                             ),
// // // //                                             filled: true,
// // // //                                             fillColor: Colors.grey.shade100,
// // // //                                           ),
// // // //                                           style: GoogleFonts.poppins(),
// // // //                                           keyboardType: TextInputType.number,
// // // //                                           controller: TextEditingController(text: acompte.toString()),
// // // //                                         ),
// // // //                                         const SizedBox(height: 12),
// // // //                                         ElevatedButton(
// // // //                                           onPressed: () async {
// // // //                                             print('Création facture finale');
// // // //                                             try {
// // // //                                               final finalInvoice = Facture(
// // // //                                                 numero: '',
// // // //                                                 type: FactureType.standard,
// // // //                                                 statut: StatutFacture.brouillon,
// // // //                                                 dateEmission: DateTime.now(),
// // // //                                                 dateEcheance: DateTime.now().add(const Duration(days: 30)),
// // // //                                                 clientNom: clientController.text,
// // // //                                                 siret: siretController.text,
// // // //                                                 clientSiret: clientSiretController.text,
// // // //                                                 adresseFournisseur: adresseFournisseurController.text,
// // // //                                                 penalitesRetard: penalitesRetardController.text,
// // // //                                                 devise: deviseController.text,
// // // //                                                 lignes: lignes,
// // // //                                                 acompte: acompte,
// // // //                                                 invoiceRef: facture.id,
// // // //                                               );
// // // //                                               await Provider.of<InvoiceProvider>(context, listen: false).addInvoice(finalInvoice);
// // // //                                               ScaffoldMessenger.of(context).showSnackBar(
// // // //                                                 const SnackBar(content: Text(Strings.factureAjoutee)),
// // // //                                               );
// // // //                                             } catch (e) {
// // // //                                               ScaffoldMessenger.of(context).showSnackBar(
// // // //                                                 SnackBar(content: Text('${Strings.erreurReseau}$e')),
// // // //                                               );
// // // //                                             }
// // // //                                           },
// // // //                                           style: ElevatedButton.styleFrom(
// // // //                                             backgroundColor: InvoiceTheme.colors.success,
// // // //                                             shape: RoundedRectangleBorder(
// // // //                                               borderRadius: BorderRadius.circular(12),
// // // //                                             ),
// // // //                                           ),
// // // //                                           child: Text(
// // // //                                             'Créer facture finale',
// // // //                                             style: GoogleFonts.poppins(
// // // //                                               color: Colors.white,
// // // //                                               fontWeight: FontWeight.w600,
// // // //                                             ),
// // // //                                           ),
// // // //                                         ),
// // // //                                       ],
// // // //                                       if (type == FactureType.avoir) ...[
// // // //                                         const SizedBox(height: 12),
// // // //                                         TextField(
// // // //                                           onChanged: (v) => motifAvoir = v,
// // // //                                           decoration: InputDecoration(
// // // //                                             labelText: 'Motif de l’avoir*',
// // // //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                             border: OutlineInputBorder(
// // // //                                               borderRadius: BorderRadius.circular(12),
// // // //                                             ),
// // // //                                             filled: true,
// // // //                                             fillColor: Colors.grey.shade100,
// // // //                                           ),
// // // //                                           style: GoogleFonts.poppins(),
// // // //                                           controller: TextEditingController(text: motifAvoir),
// // // //                                         ),
// // // //                                         const SizedBox(height: 12),
// // // //                                         DropdownButtonFormField<String>(
// // // //                                           value: creditType ?? 'credit',
// // // //                                           items: [
// // // //                                             DropdownMenuItem(
// // // //                                               value: 'credit',
// // // //                                               child: Text('Crédit client', style: GoogleFonts.poppins()),
// // // //                                             ),
// // // //                                             DropdownMenuItem(
// // // //                                               value: 'remboursement',
// // // //                                               child: Text('Remboursement', style: GoogleFonts.poppins()),
// // // //                                             ),
// // // //                                           ],
// // // //                                           onChanged: (v) => setState(() => creditType = v!),
// // // //                                           decoration: InputDecoration(
// // // //                                             labelText: 'Type d’avoir*',
// // // //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                             border: OutlineInputBorder(
// // // //                                               borderRadius: BorderRadius.circular(12),
// // // //                                             ),
// // // //                                             filled: true,
// // // //                                             fillColor: Colors.grey.shade100,
// // // //                                           ),
// // // //                                           style: GoogleFonts.poppins(),
// // // //                                         ),
// // // //                                       ],
// // // //                                       if (type == FactureType.devis) ...[
// // // //                                         const SizedBox(height: 12),
// // // //                                         ElevatedButton(
// // // //                                           onPressed: () async {
// // // //                                             validiteDevis = await showDatePicker(
// // // //                                               context: context,
// // // //                                               initialDate: validiteDevis ?? DateTime.now().add(const Duration(days: 30)),
// // // //                                               firstDate: DateTime.now(),
// // // //                                               lastDate: DateTime(2030),
// // // //                                             );
// // // //                                             setState(() {});
// // // //                                           },
// // // //                                           style: ElevatedButton.styleFrom(
// // // //                                             backgroundColor: InvoiceTheme.colors.primary,
// // // //                                             shape: RoundedRectangleBorder(
// // // //                                               borderRadius: BorderRadius.circular(12),
// // // //                                             ),
// // // //                                           ),
// // // //                                           child: Text(
// // // //                                             'Validité*: ${validiteDevis != null ? DateFormat('dd/MM/yyyy').format(validiteDevis!) : "30 jours"}',
// // // //                                             style: GoogleFonts.poppins(
// // // //                                               color: Colors.white,
// // // //                                               fontWeight: FontWeight.w600,
// // // //                                             ),
// // // //                                           ),
// // // //                                         ),
// // // //                                         const SizedBox(height: 12),
// // // //                                         TextField(
// // // //                                           onChanged: (v) => signature = v,
// // // //                                           decoration: InputDecoration(
// // // //                                             labelText: 'Signature (facultatif)',
// // // //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // // //                                             border: OutlineInputBorder(
// // // //                                               borderRadius: BorderRadius.circular(12),
// // // //                                             ),
// // // //                                             filled: true,
// // // //                                             fillColor: Colors.grey.shade100,
// // // //                                           ),
// // // //                                           style: GoogleFonts.poppins(),
// // // //                                           controller: TextEditingController(text: signature),
// // // //                                         ),
// // // //                                       ],
// // // //                                       const SizedBox(height: 12),
// // // //                                       Container(
// // // //                                         padding: const EdgeInsets.all(12),
// // // //                                         decoration: BoxDecoration(
// // // //                                           color: InvoiceTheme.colors.secondary.withOpacity(0.1),
// // // //                                           borderRadius: BorderRadius.circular(12),
// // // //                                         ),
// // // //                                         child: Text(
// // // //                                           'Total TTC: ${NumberFormat.currency(symbol: deviseController.text.isEmpty ? "XOF" : deviseController.text).format(lignes.fold(0.0, (sum, l) => sum + l.montantTTC))}',
// // // //                                           style: GoogleFonts.poppins(
// // // //                                             fontSize: 16,
// // // //                                             fontWeight: FontWeight.bold,
// // // //                                             color: InvoiceTheme.colors.secondary,
// // // //                                           ),
// // // //                                         ),
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                 ),
// // // //                               ],
// // // //                               controlsBuilder: (context, details) => Padding(
// // // //                                 padding: const EdgeInsets.symmetric(vertical: 12),
// // // //                                 child: Row(
// // // //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                                   children: [
// // // //                                     if (details.currentStep > 0)
// // // //                                       ElevatedButton(
// // // //                                         onPressed: details.onStepCancel,
// // // //                                         style: ElevatedButton.styleFrom(
// // // //                                           backgroundColor: Colors.grey.shade300,
// // // //                                           shape: RoundedRectangleBorder(
// // // //                                             borderRadius: BorderRadius.circular(12),
// // // //                                           ),
// // // //                                         ),
// // // //                                         child: Text(
// // // //                                           'Précédent',
// // // //                                           style: GoogleFonts.poppins(
// // // //                                             color: Colors.black87,
// // // //                                             fontWeight: FontWeight.w600,
// // // //                                           ),
// // // //                                         ),
// // // //                                       ),
// // // //                                     if (details.currentStep < 2)
// // // //                                       ElevatedButton(
// // // //                                         onPressed: details.onStepContinue,
// // // //                                         style: ElevatedButton.styleFrom(
// // // //                                           backgroundColor: InvoiceTheme.colors.primary,
// // // //                                           shape: RoundedRectangleBorder(
// // // //                                             borderRadius: BorderRadius.circular(12),
// // // //                                           ),
// // // //                                         ),
// // // //                                         child: Text(
// // // //                                           'Suivant',
// // // //                                           style: GoogleFonts.poppins(
// // // //                                             color: Colors.white,
// // // //                                             fontWeight: FontWeight.w600,
// // // //                                           ),
// // // //                                         ),
// // // //                                       ),
// // // //                                   ],
// // // //                                 ),
// // // //                               ),
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 16),
// // // //                     Row(
// // // //                       mainAxisAlignment: MainAxisAlignment.end,
// // // //                       children: [
// // // //                         TextButton(
// // // //                           onPressed: () {
// // // //                             print('Annulation du formulaire');
// // // //                             Navigator.pop(context);
// // // //                           },
// // // //                           child: Text(
// // // //                             'Annuler',
// // // //                             style: GoogleFonts.poppins(
// // // //                               color: InvoiceTheme.colors.primary,
// // // //                               fontWeight: FontWeight.w600,
// // // //                             ),
// // // //                           ),
// // // //                         ),
// // // //                         const SizedBox(width: 8),
// // // //                         ElevatedButton(
// // // //                           onPressed: () {
// // // //                             print('Validation du formulaire');
// // // //                             if (clientController.text.isEmpty ||
// // // //                                 lignes.any((l) => l.description.isEmpty || l.quantite <= 0 || l.prixUnitaire <= 0)) {
// // // //                               ScaffoldMessenger.of(context).showSnackBar(
// // // //                                 const SnackBar(content: Text(Strings.champsVides)),
// // // //                               );
// // // //                               return;
// // // //                             }
// // // //                             if (type == FactureType.recurrente && (frequence?.isEmpty == true || dateFin == null)) {
// // // //                               ScaffoldMessenger.of(context).showSnackBar(
// // // //                                 const SnackBar(content: Text('Fréquence et date de fin obligatoires pour récurrente')),
// // // //                               );
// // // //                               return;
// // // //                             }
// // // //                             if (type == FactureType.acompte && (invoiceRef?.isEmpty == true || acompte <= 0)) {
// // // //                               ScaffoldMessenger.of(context).showSnackBar(
// // // //                                 const SnackBar(content: Text('Référence et acompte positif requis')),
// // // //                               );
// // // //                               return;
// // // //                             }
// // // //                             if (type == FactureType.avoir && (invoiceRef?.isEmpty == true || motifAvoir?.isEmpty == true)) {
// // // //                               ScaffoldMessenger.of(context).showSnackBar(
// // // //                                 const SnackBar(content: Text('Référence et motif requis pour avoir')),
// // // //                               );
// // // //                               return;
// // // //                             }
// // // //                             if (type == FactureType.devis && validiteDevis == null) {
// // // //                               ScaffoldMessenger.of(context).showSnackBar(
// // // //                                 const SnackBar(content: Text('Validité obligatoire pour devis')),
// // // //                               );
// // // //                               return;
// // // //                             }
// // // //                             print('Facture validée: ${numeroController.text}');
// // // //                             Navigator.pop(
// // // //                               context,
// // // //                               Facture(
// // // //                                 id: facture.id,
// // // //                                 numero: numeroController.text,
// // // //                                 type: type,
// // // //                                 statut: facture.statut,
// // // //                                 dateEmission: facture.dateEmission,
// // // //                                 dateEcheance: facture.dateEcheance,
// // // //                                 clientNom: clientController.text,
// // // //                                 siret: siretController.text.isEmpty ? null : siretController.text,
// // // //                                 clientSiret: clientSiretController.text.isEmpty ? null : clientSiretController.text,
// // // //                                 adresseFournisseur: adresseFournisseurController.text.isEmpty ? null : adresseFournisseurController.text,
// // // //                                 penalitesRetard: penalitesRetardController.text.isEmpty ? "5000 FCFA + 2% par mois" : penalitesRetardController.text,
// // // //                                 devise: deviseController.text.isEmpty ? 'XOF' : deviseController.text,
// // // //                                 lignes: lignes,
// // // //                                 frequence: frequence,
// // // //                                 dateFin: dateFin,
// // // //                                 invoiceRef: invoiceRef,
// // // //                                 acompte: acompte,
// // // //                                 revisionPrix: revisionPrix,
// // // //                                 motifAvoir: motifAvoir,
// // // //                                 creditType: creditType,
// // // //                                 validiteDevis: validiteDevis,
// // // //                                 signature: signature,
// // // //                               ),
// // // //                             );
// // // //                           },
// // // //                           style: ElevatedButton.styleFrom(
// // // //                             backgroundColor: InvoiceTheme.colors.success,
// // // //                             shape: RoundedRectangleBorder(
// // // //                               borderRadius: BorderRadius.circular(12),
// // // //                             ),
// // // //                           ),
// // // //                           child: Text(
// // // //                             'Enregistrer',
// // // //                             style: GoogleFonts.poppins(
// // // //                               color: Colors.white,
// // // //                               fontWeight: FontWeight.w600,
// // // //                             ),
// // // //                           ),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             ).animate().fadeIn(duration: 300.ms).scale(),
// // // //           );
// // // //         },
// // // //       );

// // // //       print('Résultat du showDialog: ${result != null ? result.toJson() : "null"}');
// // // //       if (result != null) {
// // // //         print('Résultat du formulaire: ${result.toJson()}');
// // // //         if (result.id != null) {
// // // //           try {
// // // //             await Provider.of<InvoiceProvider>(context, listen: false)
// // // //                 .updateInvoice(result.id!, result);
// // // //             ScaffoldMessenger.of(context).showSnackBar(
// // // //               const SnackBar(content: Text(Strings.factureAjoutee)),
// // // //             );
// // // //           } catch (e) {
// // // //             ScaffoldMessenger.of(context).showSnackBar(
// // // //               SnackBar(content: Text('${Strings.erreurReseau}$e')),
// // // //             );
// // // //           }
// // // //         } else {
// // // //           try {
// // // //             await Provider.of<InvoiceProvider>(context, listen: false)
// // // //                 .addInvoice(result);
// // // //             ScaffoldMessenger.of(context).showSnackBar(
// // // //               const SnackBar(content: Text(Strings.factureAjoutee)),
// // // //             );
// // // //           } catch (e) {
// // // //             ScaffoldMessenger.of(context).showSnackBar(
// // // //               SnackBar(content: Text('${Strings.erreurReseau}$e')),
// // // //             );
// // // //           }
// // // //         }
// // // //       } else {
// // // //         print('Formulaire annulé');
// // // //       }
// // // //     } catch (e) {
// // // //       print('Erreur dans _editInvoice: $e');
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(content: Text('${Strings.erreurReseau}$e')),
// // // //       );
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text(
// // // //           'Factures',
// // // //           style: GoogleFonts.poppins(
// // // //             fontWeight: FontWeight.w600,
// // // //             color: Colors.white,
// // // //           ),
// // // //         ),
// // // //         actions: [
// // // //           Consumer<InvoiceProvider>(
// // // //             builder: (context, provider, child) => DropdownButton<String>(
// // // //               value: provider.filter,
// // // //               items: ['Toutes', 'Annulées', 'Récurrentes']
// // // //                   .map((f) => DropdownMenuItem(value: f, child: Text(f, style: GoogleFonts.poppins())))
// // // //                   .toList(),
// // // //               onChanged: (v) {
// // // //                 provider.setFilter(v!);
// // // //               },
// // // //               style: GoogleFonts.poppins(color: Colors.white),
// // // //               dropdownColor: InvoiceTheme.colors.primary,
// // // //               icon: const Icon(Icons.filter_list, color: Colors.white),
// // // //             ),
// // // //           ),
// // // //           IconButton(
// // // //             icon: const Icon(Icons.refresh, color: Colors.white),
// // // //             onPressed: () => Provider.of<InvoiceProvider>(context, listen: false).fetchInvoices(),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       body: _buildInvoiceList(context),
// // // //       floatingActionButton: FloatingActionButton(
// // // //         backgroundColor: InvoiceTheme.colors.primary,
// // // //         onPressed: () {
// // // //           print('Bouton plus cliqué');
// // // //           _editInvoice(
// // // //             context,
// // // //             Facture(
// // // //               id: null,
// // // //               numero: '',
// // // //               type: FactureType.standard,
// // // //               statut: StatutFacture.brouillon,
// // // //               dateEmission: DateTime.now(),
// // // //               dateEcheance: DateTime.now().add(const Duration(days: 30)),
// // // //               clientNom: '',
// // // //               lignes: [],
// // // //               penalitesRetard: "5000 FCFA + 2% par mois",
// // // //               devise: 'XOF',
// // // //             ),
// // // //           );
// // // //         },
// // // //         child: const Icon(Icons.add, color: Colors.white),
// // // //       ),
// // // //     );
// // // //   }
// // // // }












// // // // filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/features/invoicing/screens/invoice_screen.dart

// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:intl/intl.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:flutter_animate/flutter_animate.dart';

// // // import 'package:ComptaFacile/core/constants/strings.dart';
// // // import 'package:ComptaFacile/core/theme/invoice_theme.dart';
// // // import 'package:ComptaFacile/features/invoicing/providers/invoice_provider.dart';
// // // import 'package:ComptaFacile/features/invoicing/screens/invoice_model.dart';
// // // import 'package:ComptaFacile/features/invoicing/invoice_card.dart';

// // // extension StringExtension on String {
// // //   String capitalize() {
// // //     if (isEmpty) return this;
// // //     return '${this[0].toUpperCase()}${substring(1)}';
// // //   }
// // // }

// // // class InvoiceScreen extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Invoice Screen'),
// // //       ),
// // //       body: Center(
// // //         child: Text('Invoice Screen Content'),
// // //       ),
// // //     );
// // //   }
// // //   const InvoiceScreen({Key? key}) : super(key: key);

// // //   // ==================== Widget Builders ====================

// // //   Widget _buildFormActionButtons(
// // //     BuildContext context,
// // //     Facture facture,
// // //     Map<String, dynamic> formData,
// // //   ) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.end,
// // //       children: [
// // //         TextButton(
// // //           onPressed: () => Navigator.pop(context),
// // //           child: Text(
// // //             'Annuler',
// // //             style: GoogleFonts.poppins(
// // //               color: InvoiceTheme.colors.primary,
// // //               fontWeight: FontWeight.w600,
// // //             ),
// // //           ),
// // //         ),
// // //         const SizedBox(width: 8),
// // //         ElevatedButton(
// // //           onPressed: () => _validateAndSubmitForm(context, facture, formData),
// // //           style: ElevatedButton.styleFrom(
// // //             backgroundColor: InvoiceTheme.colors.success,
// // //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //           ),
// // //           child: Text(
// // //             'Enregistrer',
// // //             style: GoogleFonts.poppins(
// // //               color: Colors.white,
// // //               fontWeight: FontWeight.w600,
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildInvoiceLineFields(
// // //     List<LigneFacture> lignes, 
// // //     int index, 
// // //     StateSetter setState, 
// // //     BuildContext context
// // //   ) {
// // //     final ligne = lignes[index];
// // //     final controllers = _createLineControllers(ligne);

// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// // //       child: Column(
// // //         children: [
// // //           _buildLineTextField(
// // //             context: context,
// // //             controller: controllers['description']!,
// // //             label: 'Description*',
// // //             onChanged: (value) => ligne.description = value,
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildLineTextField(
// // //             context: context,
// // //             controller: controllers['quantite']!,
// // //             label: 'Quantité*',
// // //             keyboardType: TextInputType.number,
// // //             onChanged: (value) => ligne.quantite = int.tryParse(value) ?? 1,
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildLineTextField(
// // //             context: context,
// // //             controller: controllers['prixUnitaire']!,
// // //             label: 'Prix Unitaire*',
// // //             keyboardType: TextInputType.number,
// // //             onChanged: (value) => ligne.prixUnitaire = double.tryParse(value) ?? 0,
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildLineTextField(
// // //             context: context,
// // //             controller: controllers['tva']!,
// // //             label: 'TVA (%)*',
// // //             keyboardType: TextInputType.number,
// // //             onChanged: (value) => ligne.tva = double.tryParse(value) ?? 0,
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildLineTextField(
// // //             context: context,
// // //             controller: controllers['remise']!,
// // //             label: 'Remise (%)',
// // //             keyboardType: TextInputType.number,
// // //             onChanged: (value) => ligne.remise = double.tryParse(value) ?? 0,
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildDeleteLineButton(context, () => setState(() => lignes.removeAt(index))),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildInvoiceList(BuildContext context) {
// // //     return Consumer<InvoiceProvider>(
// // //       builder: (context, provider, child) {
// // //         if (provider.isLoading) return const Center(child: CircularProgressIndicator());
// // //         if (provider.error != null) return Center(child: Text('${Strings.erreurChargement}${provider.error}'));
        
// // //         final invoices = _filterInvoices(provider);
// // //         if (invoices.isEmpty) return const Center(child: Text(Strings.aucuneFacture));

// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(8),
// // //           itemCount: invoices.length,
// // //           itemBuilder: (context, index) {
// // //             final facture = invoices[index];
// // //             return InvoiceCard(
// // //               facture: facture,
// // //               onConvert: _getConvertCallback(provider, facture),
// // //               onCancel: _getCancelCallback(context, facture),
// // //               onDelete: _getDeleteCallback(context, facture),
// // //               onEdit: _getEditCallback(context, facture),
// // //               onStatusChange: null,
// // //               onPdf: _getPdfCallback(context, provider, facture),
// // //               onTap: () => _showInvoiceSelectedSnackbar(context, facture),
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }

// // //   // ==================== Helper Methods ====================

// // //   Map<String, TextEditingController> _createLineControllers(LigneFacture ligne) {
// // //     return {
// // //       'description': TextEditingController(text: ligne.description),
// // //       'quantite': TextEditingController(text: ligne.quantite.toString()),
// // //       'prixUnitaire': TextEditingController(text: ligne.prixUnitaire.toString()),
// // //       'tva': TextEditingController(text: ligne.tva.toString()),
// // //       'remise': TextEditingController(text: ligne.remise.toString()),
// // //     };
// // //   }

// // //   Widget _buildLineTextField({
// // //     required BuildContext context,
// // //     required TextEditingController controller,
// // //     required String label,
// // //     required ValueChanged<String> onChanged,
// // //     TextInputType keyboardType = TextInputType.text,
// // //   }) {
// // //     return TextField(
// // //       controller: controller,
// // //       decoration: InputDecoration(
// // //         labelText: label,
// // //         labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //         filled: true,
// // //         fillColor: Colors.grey.shade100,
// // //       ),
// // //       style: GoogleFonts.poppins(),
// // //       keyboardType: keyboardType,
// // //       onChanged: onChanged,
// // //     );
// // //   }

// // //   Widget _buildDeleteLineButton(BuildContext context, VoidCallback onPressed) {
// // //     return TextButton(
// // //       onPressed: onPressed,
// // //       child: Text(
// // //         'Supprimer ligne',
// // //         style: GoogleFonts.poppins(
// // //           color: InvoiceTheme.colors.error,
// // //           fontWeight: FontWeight.w600,
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   List<Facture> _filterInvoices(InvoiceProvider provider) {
// // //     switch (provider.filter) {
// // //       case 'Annulées':
// // //         return provider.invoices.where((f) => f.statut == StatutFacture.annulee).toList();
// // //       case 'Récurrentes':
// // //         return provider.invoices.where((f) => f.type == FactureType.recurrente || f.parentInvoice != null).toList();
// // //       default:
// // //         return provider.invoices;
// // //     }
// // //   }

// // //   // ==================== Callback Methods ====================

// // //   VoidCallback? _getConvertCallback(InvoiceProvider provider, Facture facture) {
// // //     return facture.type == FactureType.devis &&
// // //             facture.statut != StatutFacture.payee &&
// // //             facture.id != null
// // //         ? () => provider.convertDevis(facture.id!)
// // //         : null;
// // //   }

// // //   VoidCallback? _getCancelCallback(BuildContext context, Facture facture) {
// // //     return facture.statut != StatutFacture.annulee && facture.id != null
// // //         ? () => _cancelInvoice(context, facture.id!)
// // //         : null;
// // //   }

// // //   VoidCallback? _getDeleteCallback(BuildContext context, Facture facture) {
// // //     return facture.id != null &&
// // //             facture.statut != StatutFacture.payee &&
// // //             facture.statut != StatutFacture.annulee
// // //         ? () => _deleteInvoice(context, facture.id!)
// // //         : null;
// // //   }

// // //   VoidCallback? _getEditCallback(BuildContext context, Facture facture) {
// // //     return facture.id != null &&
// // //             facture.statut != StatutFacture.payee &&
// // //             facture.statut != StatutFacture.annulee
// // //         ? () => _editInvoice(context, facture)
// // //         : null;
// // //   }

// // //   VoidCallback? _getPdfCallback(BuildContext context, InvoiceProvider provider, Facture facture) {
// // //     return facture.id != null
// // //         ? () async {
// // //             try {
// // //               final url = await provider.generatePdf(facture.id!);
// // //               ScaffoldMessenger.of(context).showSnackBar(
// // //                 SnackBar(content: Text('${Strings.pdfExporte}$url')),
// // //               );
// // //             } catch (e) {
// // //               ScaffoldMessenger.of(context).showSnackBar(
// // //                 SnackBar(content: Text('${Strings.erreurExport}$e')),
// // //               );
// // //             }
// // //           }
// // //         : null;
// // //   }

// // //   void _showInvoiceSelectedSnackbar(BuildContext context, Facture facture) {
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(content: Text('Facture ${facture.numero} sélectionnée')),
// // //     );
// // //   }

// // //   // ==================== Invoice Operations ====================

// // //   Future<void> _cancelInvoice(BuildContext context, String id) async {
// // //     final motifController = TextEditingController();
// // //     final confirm = await _showCancelDialog(context, motifController);

// // //     if (confirm == true) {
// // //       try {
// // //         await Provider.of<InvoiceProvider>(context, listen: false)
// // //             .cancelInvoice(id, motifController.text);
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Facture annulée avec succès')),
// // //         );
// // //       } catch (e) {
// // //         _handleCancelError(context, e);
// // //       }
// // //     }
// // //   }

// // //   Future<bool?> _showCancelDialog(BuildContext context, TextEditingController motifController) {
// // //     return showDialog<bool>(
// // //       context: context,
// // //       builder: (context) => Dialog(
// // //         backgroundColor: Colors.white,
// // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               Text(
// // //                 'Annuler facture',
// // //                 style: GoogleFonts.poppins(
// // //                   fontWeight: FontWeight.w600,
// // //                   color: InvoiceTheme.colors.primary,
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 12),
// // //               _buildLineTextField(
// // //                 context: context,
// // //                 controller: motifController,
// // //                 label: "Motif d'annulation*",
// // //               ),
// // //               const SizedBox(height: 16),
// // //               _buildDialogActionButtons(context, motifController),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildDialogActionButtons(BuildContext context, TextEditingController? motifController) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.end,
// // //       children: [
// // //         TextButton(
// // //           onPressed: () => Navigator.pop(context, false),
// // //           child: Text(
// // //             'Annuler',
// // //             style: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //           ),
// // //         ),
// // //         TextButton(
// // //           onPressed: () => _validateAndCloseDialog(context, motifController),
// // //           child: Text(
// // //             'Confirmer',
// // //             style: GoogleFonts.poppins(
// // //               color: InvoiceTheme.colors.success,
// // //               fontWeight: FontWeight.w600,
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   void _validateAndCloseDialog(BuildContext context, TextEditingController? controller) {
// // //     if (controller != null && controller.text.isEmpty) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text('Le motif est requis')),
// // //       );
// // //       return;
// // //     }
// // //     Navigator.pop(context, true);
// // //   }

// // //   void _handleCancelError(BuildContext context, dynamic error) {
// // //     String errorMessage = error.toString();
// // //     if (errorMessage.contains('Token requis') || errorMessage.contains('Aucun token')) {
// // //       errorMessage = 'Veuillez vous reconnecter pour annuler la facture.';
// // //     } else if (errorMessage.contains('payée')) {
// // //       errorMessage = 'Cette facture est payée et ne peut pas être annulée.';
// // //     } else if (errorMessage.contains('annulée')) {
// // //       errorMessage = 'Cette facture est déjà annulée.';
// // //     } else {
// // //       errorMessage = '${Strings.erreurReseau}$errorMessage';
// // //     }
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(content: Text(errorMessage)),
// // //     );
// // //   }

// // //   Future<void> _deleteInvoice(BuildContext context, String id) async {
// // //     final confirm = await _showDeleteDialog(context);
// // //     if (confirm == true) {
// // //       try {
// // //         await Provider.of<InvoiceProvider>(context, listen: false).deleteInvoice(id);
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Facture supprimée avec succès')),
// // //         );
// // //       } catch (e) {
// // //         _handleDeleteError(context, e);
// // //       }
// // //     }
// // //   }

// // //   Future<bool?> _showDeleteDialog(BuildContext context) {
// // //     return showDialog<bool>(
// // //       context: context,
// // //       builder: (context) => Dialog(
// // //         backgroundColor: Colors.white,
// // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               Text(
// // //                 'Supprimer facture',
// // //                 style: GoogleFonts.poppins(
// // //                   fontWeight: FontWeight.w600,
// // //                   color: InvoiceTheme.colors.primary,
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 12),
// // //               Text(
// // //                 'Êtes-vous sûr de vouloir supprimer cette facture ?',
// // //                 style: GoogleFonts.poppins(),
// // //               ),
// // //               const SizedBox(height: 16),
// // //               _buildDialogActionButtons(context, null),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _handleDeleteError(BuildContext context, dynamic error) {
// // //     String errorMessage = error.toString();
// // //     if (errorMessage.contains('payée') || errorMessage.contains('annulée')) {
// // //       errorMessage = 'Erreur : Facture payée ou annulée ne peut pas être supprimée.';
// // //     } else {
// // //       errorMessage = '${Strings.erreurReseau}$errorMessage';
// // //     }
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(content: Text(errorMessage)),
// // //     );
// // //   }

// // //   // ==================== Edit Invoice ====================

// // //   Future<void> _editInvoice(BuildContext context, Facture facture) async {
// // //     print('Démarrage _editInvoice pour facture: ${facture.numero}');
    
// // //     final formData = _initializeFormData(facture);
// // //     int currentStep = 0;

// // //     try {
// // //       final result = await _showInvoiceFormDialog(context, facture, formData, currentStep);
      
// // //       if (result != null) {
// // //         await _handleFormSubmission(context, result);
// // //       }
// // //     } catch (e) {
// // //       _handleFormError(context, e);
// // //     }
// // //   }

// // //   Future<void> _handleFormSubmission(BuildContext context, Facture result) async {
// // //     if (result.id != null) {
// // //       try {
// // //         await Provider.of<InvoiceProvider>(context, listen: false)
// // //             .updateInvoice(result.id!, result);
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text(Strings.factureAjoutee)),
// // //         );
// // //       } catch (e) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('${Strings.erreurReseau}$e')),
// // //         );
// // //       }
// // //     } else {
// // //       try {
// // //         await Provider.of<InvoiceProvider>(context, listen: false)
// // //             .addInvoice(result);
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text(Strings.factureAjoutee)),
// // //         );
// // //       } catch (e) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('${Strings.erreurReseau}$e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   void _handleFormError(BuildContext context, dynamic error) {
// // //     print('Erreur dans _editInvoice: $error');
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(content: Text('${Strings.erreurReseau}$error')),
// // //     );
// // //   }

// // //   Map<String, dynamic> _initializeFormData(Facture facture) {
// // //     return {
// // //       'numero': TextEditingController(text: facture.numero),
// // //       'client': TextEditingController(text: facture.clientNom),
// // //       'siret': TextEditingController(text: facture.siret),
// // //       'clientSiret': TextEditingController(text: facture.clientSiret),
// // //       'adresseFournisseur': TextEditingController(text: facture.adresseFournisseur),
// // //       'penalitesRetard': TextEditingController(text: facture.penalitesRetard),
// // //       'devise': TextEditingController(text: facture.devise ?? 'XOF'),
// // //       'lignes': List.from(facture.lignes),
// // //       'type': facture.type,
// // //       'frequence': facture.frequence,
// // //       'dateFin': facture.dateFin,
// // //       'invoiceRef': facture.invoiceRef,
// // //       'acompte': facture.acompte,
// // //       'revisionPrix': facture.revisionPrix,
// // //       'motifAvoir': facture.motifAvoir,
// // //       'creditType': facture.creditType,
// // //       'validiteDevis': facture.validiteDevis,
// // //       'signature': facture.signature,
// // //     };
// // //   }

// // //   Future<Facture?> _showInvoiceFormDialog(
// // //     BuildContext context,
// // //     Facture facture,
// // //     Map<String, dynamic> formData,
// // //     int currentStep,
// // //   ) {
// // //     return showDialog<Facture>(
// // //       context: context,
// // //       barrierDismissible: false,
// // //       barrierColor: Colors.black.withOpacity(0.5),
// // //       builder: (context) {
// // //         return StatefulBuilder(
// // //           builder: (context, setState) => Dialog(
// // //             backgroundColor: Colors.white,
// // //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // //             child: Container(
// // //               width: MediaQuery.of(context).size.width * 0.95,
// // //               height: MediaQuery.of(context).size.height * 0.95,
// // //               padding: const EdgeInsets.all(16),
// // //               child: Column(
// // //                 children: [
// // //                   _buildFormTitle(facture),
// // //                   const SizedBox(height: 16),
// // //                   Expanded(
// // //                     child: SingleChildScrollView(
// // //                       physics: const ClampingScrollPhysics(),
// // //                       child: Column(
// // //                         mainAxisSize: MainAxisSize.min,
// // //                         children: [
// // //                           _buildFormStepper(context, setState, formData, currentStep),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 16),
// // //                   _buildFormActionButtons(context, facture, formData),
// // //                 ],
// // //               ),
// // //             ),
// // //           ).animate().fadeIn(duration: 300.ms).scale(),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   Widget _buildFormTitle(Facture facture) {
// // //     return Text(
// // //       facture.id == null ? 'Nouvelle facture' : 'Modifier facture',
// // //       style: GoogleFonts.poppins(
// // //         fontSize: 22,
// // //         fontWeight: FontWeight.w600,
// // //         color: InvoiceTheme.colors.primary,
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildFormStepper(
// // //     BuildContext context,
// // //     StateSetter setState,
// // //     Map<String, dynamic> formData,
// // //     int currentStep,
// // //   ) {
// // //     return Stepper(
// // //       currentStep: currentStep,
// // //       onStepContinue: () {
// // //         if (currentStep < 2) setState(() => currentStep++);
// // //       },
// // //       onStepCancel: () {
// // //         if (currentStep > 0) setState(() => currentStep--);
// // //       },
// // //       steps: [
// // //         _buildClientStep(currentStep, formData),
// // //         _buildLinesStep(currentStep, formData, setState, context),
// // //         _buildOptionsStep(currentStep, formData, setState, context),
// // //       ],
// // //       controlsBuilder: (context, details) => _buildStepperControls(details),
// // //     );
// // //   }
// // //   Step _buildClientStep(BuildContext context, int currentStep, Map<String, dynamic> formData) {
// // //   Step _buildClientStep(int currentStep, Map<String, dynamic> formData) {
// // //     return Step(
// // //       title: _buildStepTitle('Client', currentStep, 0),
// // //       content: Column(
// // //         children: [
// // //           _buildLineTextField(
// // //             context: context,
// // //             controller: formData['numero'],
// // //             label: 'Numéro*',
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildLineTextField(
// // //             context: context,
// // //             controller: formData['client'],
// // //             label: 'Client*',
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildLineTextField(
// // //             context: context,
// // //             controller: formData['siret'],
// // //             label: 'SIRET Fournisseur*',
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildLineTextField(
// // //             context: context,
// // //             controller: formData['clientSiret'],
// // //             label: 'SIRET Client',
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildLineTextField(
// // //             context: context,
// // //             controller: formData['adresseFournisseur'],
// // //             label: 'Adresse Fournisseur*',
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildLineTextField(
// // //             context: context,
// // //             controller: formData['penalitesRetard'],
// // //             label: 'Pénalités de retard*',
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildCurrencyDropdown(formData),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Step _buildLinesStep(
// // //     int currentStep,
// // //     Map<String, dynamic> formData,
// // //     StateSetter setState,
// // //     BuildContext context,
// // //   ) {
// // //     return Step(
// // //       title: _buildStepTitle('Lignes', currentStep, 1),
// // //       content: Column(
// // //         children: [
// // //           ListView.builder(
// // //             shrinkWrap: true,
// // //             physics: const NeverScrollableScrollPhysics(),
// // //             itemCount: formData['lignes'].length,
// // //             itemBuilder: (context, index) {
// // //               return _buildInvoiceLineFields(
// // //                 formData['lignes'], 
// // //                 index, 
// // //                 setState, 
// // //                 context,
// // //               );
// // //             },
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildAddLineButton(setState, formData),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Step _buildOptionsStep(
// // //     int currentStep,
// // //     Map<String, dynamic> formData,
// // //     StateSetter setState,
// // //     BuildContext context,
// // //   ) {
// // //     return Step(
// // //       title: _buildStepTitle('Options', currentStep, 2),
// // //       content: Column(
// // //         children: [
// // //           _buildTypeDropdown(formData, setState),
// // //           const SizedBox(height: 12),
// // //           if (formData['type'] == FactureType.recurrente) ...[
// // //             _buildRecurringFields(formData, setState, context),
// // //           ],
// // //           if (formData['type'] == FactureType.acompte || formData['type'] == FactureType.avoir) ...[
// // //             _buildReferenceField(formData),
// // //           ],
// // //           if (formData['type'] == FactureType.acompte) ...[
// // //             _buildDepositFields(formData, context),
// // //           ],
// // //           if (formData['type'] == FactureType.avoir) ...[
// // //             _buildCreditFields(formData),
// // //           ],
// // //           if (formData['type'] == FactureType.devis) ...[
// // //             _buildQuoteFields(formData, setState, context),
// // //           ],
// // //           const SizedBox(height: 12),
// // //           _buildTotalDisplay(formData),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildStepTitle(String title, int currentStep, int stepIndex) {
// // //     return Text(
// // //       title,
// // //       style: GoogleFonts.poppins(
// // //         color: currentStep == stepIndex
// // //             ? InvoiceTheme.colors.primary
// // //             : Colors.grey.shade600,
// // //         fontWeight: FontWeight.w600,
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildCurrencyDropdown(Map<String, dynamic> formData) {
// // //     return DropdownButtonFormField<String>(
// // //       value: formData['devise'].text.isEmpty ? 'XOF' : formData['devise'].text,
// // //       items: ['XOF', 'EUR', 'USD', 'XAF']
// // //           .map((d) => DropdownMenuItem(value: d, child: Text(d, style: GoogleFonts.poppins())))
// // //           .toList(),
// // //       onChanged: (v) => formData['devise'].text = v!,
// // //       decoration: InputDecoration(
// // //         labelText: 'Devise*',
// // //         labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //         filled: true,
// // //         fillColor: Colors.grey.shade100,
// // //       ),
// // //       style: GoogleFonts.poppins(),
// // //     );
// // //   }

// // //   Widget _buildAddLineButton(StateSetter setState, Map<String, dynamic> formData) {
// // //     return ElevatedButton(
// // //       onPressed: () => setState(() => formData['lignes'].add(LigneFacture(
// // //             description: '',
// // //             quantite: 1,
// // //             prixUnitaire: 0,
// // //             tva: 0,
// // //             remise: 0,
// // //           ))),
// // //       style: ElevatedButton.styleFrom(
// // //         backgroundColor: InvoiceTheme.colors.secondary,
// // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //       ),
// // //       child: Text(
// // //         'Ajouter ligne',
// // //         style: GoogleFonts.poppins(
// // //           color: Colors.white,
// // //           fontWeight: FontWeight.w600,
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildTypeDropdown(Map<String, dynamic> formData, StateSetter setState) {
// // //     return DropdownButtonFormField<FactureType>(
// // //       value: formData['type'],
// // //       items: FactureType.values
// // //           .map((t) => DropdownMenuItem(
// // //                 value: t,
// // //                 child: Text(
// // //                   t.toString().split('.').last.capitalize(),
// // //                   style: GoogleFonts.poppins(),
// // //                 ),
// // //               ))
// // //           .toList(),
// // //       onChanged: (v) => setState(() => formData['type'] = v!),
// // //       decoration: InputDecoration(
// // //         labelText: 'Type*',
// // //         labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //         filled: true,
// // //         fillColor: Colors.grey.shade100,
// // //       ),
// // //       style: GoogleFonts.poppins(),
// // //     );
// // //   }

// // //   Widget _buildRecurringFields(
// // //     Map<String, dynamic> formData,
// // //     StateSetter setState,
// // //     BuildContext context,
// // //   ) {
// // //     return Column(
// // //       children: [
// // //         const SizedBox(height: 12),
// // //         TextField(
// // //           onChanged: (v) => formData['frequence'] = v,
// // //           decoration: InputDecoration(
// // //             labelText: 'Fréquence* (mensuelle, trimestrielle, annuelle)',
// // //             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //             filled: true,
// // //             fillColor: Colors.grey.shade100,
// // //           ),
// // //           style: GoogleFonts.poppins(),
// // //           controller: TextEditingController(text: formData['frequence']),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         TextField(
// // //           onChanged: (v) => formData['revisionPrix'] = v,
// // //           decoration: InputDecoration(
// // //             labelText: 'Révision des prix (ex. +2%/an)',
// // //             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //             filled: true,
// // //             fillColor: Colors.grey.shade100,
// // //           ),
// // //           style: GoogleFonts.poppins(),
// // //           controller: TextEditingController(text: formData['revisionPrix']),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         ElevatedButton(
// // //           onPressed: () async {
// // //             formData['dateFin'] = await showDatePicker(
// // //               context: context,
// // //               initialDate: formData['dateFin'] ?? DateTime.now(),
// // //               firstDate: DateTime.now(),
// // //               lastDate: DateTime(2030),
// // //             );
// // //             setState(() {});
// // //           },
// // //           style: ElevatedButton.styleFrom(
// // //             backgroundColor: InvoiceTheme.colors.primary,
// // //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //           ),
// // //           child: Text(
// // //             'Date de fin*: ${formData['dateFin'] != null ? DateFormat('dd/MM/yyyy').format(formData['dateFin']) : "Non défini"}',
// // //             style: GoogleFonts.poppins(
// // //               color: Colors.white,
// // //               fontWeight: FontWeight.w600,
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildReferenceField(Map<String, dynamic> formData) {
// // //     return Column(
// // //       children: [
// // //         const SizedBox(height: 12),
// // //         TextField(
// // //           onChanged: (v) => formData['invoiceRef'] = v,
// // //           decoration: InputDecoration(
// // //             labelText: 'Référence facture (ID)*',
// // //             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //             filled: true,
// // //             fillColor: Colors.grey.shade100,
// // //           ),
// // //           style: GoogleFonts.poppins(),
// // //           controller: TextEditingController(text: formData['invoiceRef']),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildDepositFields(Map<String, dynamic> formData, BuildContext context) {
// // //     return Column(
// // //       children: [
// // //         const SizedBox(height: 12),
// // //         TextField(
// // //           onChanged: (v) => formData['acompte'] = double.tryParse(v) ?? 0,
// // //           decoration: InputDecoration(
// // //             labelText: 'Montant acompte*',
// // //             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //             filled: true,
// // //             fillColor: Colors.grey.shade100,
// // //           ),
// // //           style: GoogleFonts.poppins(),
// // //           keyboardType: TextInputType.number,
// // //           controller: TextEditingController(text: formData['acompte'].toString()),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         ElevatedButton(
// // //           onPressed: () => _createFinalInvoice(context, formData),
// // //           style: ElevatedButton.styleFrom(
// // //             backgroundColor: InvoiceTheme.colors.success,
// // //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //           ),
// // //           child: Text(
// // //             'Créer facture finale',
// // //             style: GoogleFonts.poppins(
// // //               color: Colors.white,
// // //               fontWeight: FontWeight.w600,
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildCreditFields(Map<String, dynamic> formData) {
// // //     return Column(
// // //       children: [
// // //         const SizedBox(height: 12),
// // //         TextField(
// // //           onChanged: (v) => formData['motifAvoir'] = v,
// // //           decoration: InputDecoration(
// // //             labelText: "Motif de l'avoir*",
// // //             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //             filled: true,
// // //             fillColor: Colors.grey.shade100,
// // //           ),
// // //           style: GoogleFonts.poppins(),
// // //           controller: TextEditingController(text: formData['motifAvoir']),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         DropdownButtonFormField<String>(
// // //           value: formData['creditType'] ?? 'credit',
// // //           items: [
// // //             DropdownMenuItem(
// // //               value: 'credit',
// // //               child: Text('Crédit client', style: GoogleFonts.poppins()),
// // //             ),
// // //             DropdownMenuItem(
// // //               value: 'remboursement',
// // //               child: Text('Remboursement', style: GoogleFonts.poppins()),
// // //             ),
// // //           ],
// // //           onChanged: (v) => formData['creditType'] = v!,
// // //           decoration: InputDecoration(
// // //             labelText: "Type d'avoir*",
// // //             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //             filled: true,
// // //             fillColor: Colors.grey.shade100,
// // //           ),
// // //           style: GoogleFonts.poppins(),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildQuoteFields(
// // //     Map<String, dynamic> formData,
// // //     StateSetter setState,
// // //     BuildContext context,
// // //   ) {
// // //     return Column(
// // //       children: [
// // //         const SizedBox(height: 12),
// // //         ElevatedButton(
// // //           onPressed: () async {
// // //             formData['validiteDevis'] = await showDatePicker(
// // //               context: context,
// // //               initialDate: formData['validiteDevis'] ?? DateTime.now().add(const Duration(days: 30)),
// // //               firstDate: DateTime.now(),
// // //               lastDate: DateTime(2030),
// // //             );
// // //             setState(() {});
// // //           },
// // //           style: ElevatedButton.styleFrom(
// // //             backgroundColor: InvoiceTheme.colors.primary,
// // //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //           ),
// // //           child: Text(
// // //             'Validité*: ${formData['validiteDevis'] != null ? DateFormat('dd/MM/yyyy').format(formData['validiteDevis']) : "30 jours"}',
// // //             style: GoogleFonts.poppins(
// // //               color: Colors.white,
// // //               fontWeight: FontWeight.w600,
// // //             ),
// // //           ),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         TextField(
// // //           onChanged: (v) => formData['signature'] = v,
// // //           decoration: InputDecoration(
// // //             labelText: 'Signature (facultatif)',
// // //             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //             filled: true,
// // //             fillColor: Colors.grey.shade100,
// // //           ),
// // //           style: GoogleFonts.poppins(),
// // //           controller: TextEditingController(text: formData['signature']),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildTotalDisplay(Map<String, dynamic> formData) {
// // //     return Container(
// // //       padding: const EdgeInsets.all(12),
// // //       decoration: BoxDecoration(
// // //         color: InvoiceTheme.colors.secondary.withOpacity(0.1),
// // //         borderRadius: BorderRadius.circular(12),
// // //       ),
// // //       child: Text(
// // //         'Total TTC: ${NumberFormat.currency(symbol: formData['devise'].text.isEmpty ? "XOF" : formData['devise'].text).format(formData['lignes'].fold(0.0, (sum, l) => sum + l.montantTTC))}',
// // //         style: GoogleFonts.poppins(
// // //           fontSize: 16,
// // //           fontWeight: FontWeight.bold,
// // //           color: InvoiceTheme.colors.secondary,
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildStepperControls(ControlsDetails details) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(vertical: 12),
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //         children: [
// // //           if (details.currentStep > 0)
// // //             ElevatedButton(
// // //               onPressed: details.onStepCancel,
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: Colors.grey.shade300,
// // //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //               ),
// // //               child: Text(
// // //                 'Précédent',
// // //                 style: GoogleFonts.poppins(
// // //                   color: Colors.black87,
// // //                   fontWeight: FontWeight.w600,
// // //                 ),
// // //               ),
// // //             ),
// // //           if (details.currentStep < 2)
// // //             ElevatedButton(
// // //               onPressed: details.onStepContinue,
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: InvoiceTheme.colors.primary,
// // //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //               ),
// // //               child: Text(
// // //                 'Suivant',
// // //                 style: GoogleFonts.poppins(
// // //                   color: Colors.white,
// // //                   fontWeight: FontWeight.w600,
// // //                 ),
// // //               ),
// // //             ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildFormActionButtons(
// // //     BuildContext context,
// // //     Facture facture,
// // //     Map<String, dynamic> formData,
// // //   ) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.end,
// // //       children: [
// // //         TextButton(
// // //           onPressed: () => Navigator.pop(context),
// // //           child: Text(
// // //             'Annuler',
// // //             style: GoogleFonts.poppins(
// // //               color: InvoiceTheme.colors.primary,
// // //               fontWeight: FontWeight.w600,
// // //             ),
// // //           ),
// // //         ),
// // //         const SizedBox(width: 8),
// // //         ElevatedButton(
// // //           onPressed: () => _validateAndSubmitForm(context, facture, formData),
// // //           style: ElevatedButton.styleFrom(
// // //             backgroundColor: InvoiceTheme.colors.success,
// // //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //           ),
// // //           child: Text(
// // //             'Enregistrer',
// // //             style: GoogleFonts.poppins(
// // //               color: Colors.white,
// // //               fontWeight: FontWeight.w600,
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   void _validateAndSubmitForm(
// // //     BuildContext context,
// // //     Facture facture,
// // //     Map<String, dynamic> formData,
// // //   ) {
// // //     if (formData['client'].text.isEmpty ||
// // //         formData['lignes'].any((l) => l.description.isEmpty || l.quantite <= 0 || l.prixUnitaire <= 0)) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text(Strings.champsVides)),
// // //       );
// // //       return;
// // //     }

// // //     if (formData['type'] == FactureType.recurrente && 
// // //         (formData['frequence']?.isEmpty == true || formData['dateFin'] == null)) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text('Fréquence et date de fin obligatoires pour récurrente')),
// // //       );
// // //       return;
// // //     }

// // //     if (formData['type'] == FactureType.acompte && 
// // //         (formData['invoiceRef']?.isEmpty == true || formData['acompte'] <= 0)) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text('Référence et acompte positif requis')),
// // //       );
// // //       return;
// // //     }

// // //     if (formData['type'] == FactureType.avoir && 
// // //         (formData['invoiceRef']?.isEmpty == true || formData['motifAvoir']?.isEmpty == true)) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text('Référence et motif requis pour avoir')),
// // //       );
// // //       return;
// // //     }

// // //     if (formData['type'] == FactureType.devis && formData['validiteDevis'] == null) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text('Validité obligatoire pour devis')),
// // //       );
// // //       return;
// // //     }

// // //     Navigator.pop(
// // //       context,
// // //       _createInvoiceFromFormData(facture, formData),
// // //     );
// // //   }

// // //   Facture _createInvoiceFromFormData(Facture facture, Map<String, dynamic> formData) {
// // //     return Facture(
// // //       id: facture.id,
// // //       numero: formData['numero'].text,
// // //       type: formData['type'],
// // //       statut: facture.statut,
// // //       dateEmission: facture.dateEmission,
// // //       dateEcheance: facture.dateEcheance,
// // //       clientNom: formData['client'].text,
// // //       siret: formData['siret'].text.isEmpty ? null : formData['siret'].text,
// // //       clientSiret: formData['clientSiret'].text.isEmpty ? null : formData['clientSiret'].text,
// // //       adresseFournisseur: formData['adresseFournisseur'].text.isEmpty 
// // //           ? null 
// // //           : formData['adresseFournisseur'].text,
// // //       penalitesRetard: formData['penalitesRetard'].text.isEmpty 
// // //           ? "5000 FCFA + 2% par mois" 
// // //           : formData['penalitesRetard'].text,
// // //       devise: formData['devise'].text.isEmpty ? 'XOF' : formData['devise'].text,
// // //       lignes: formData['lignes'],
// // //       frequence: formData['frequence'],
// // //       dateFin: formData['dateFin'],
// // //       invoiceRef: formData['invoiceRef'],
// // //       acompte: formData['acompte'],
// // //       revisionPrix: formData['revisionPrix'],
// // //       motifAvoir: formData['motifAvoir'],
// // //       creditType: formData['creditType'],
// // //       validiteDevis: formData['validiteDevis'],
// // //       signature: formData['signature'],
// // //     );
// // //   }

// // //   Future<void> _createFinalInvoice(BuildContext context, Map<String, dynamic> formData) async {
// // //     print('Création facture finale');
// // //     try {
// // //       final finalInvoice = Facture(
// // //         numero: '',
// // //         type: FactureType.standard,
// // //         statut: StatutFacture.brouillon,
// // //         dateEmission: DateTime.now(),
// // //         dateEcheance: DateTime.now().add(const Duration(days: 30)),
// // //         clientNom: formData['client'].text,
// // //         siret: formData['siret'].text,
// // //         clientSiret: formData['clientSiret'].text,
// // //         adresseFournisseur: formData['adresseFournisseur'].text,
// // //         penalitesRetard: formData['penalitesRetard'].text,
// // //         devise: formData['devise'].text,
// // //         lignes: formData['lignes'],
// // //         acompte: formData['acompte'],
// // //         invoiceRef: formData['invoiceRef'],
// // //       );
// // //       await Provider.of<InvoiceProvider>(context, listen: false).addInvoice(finalInvoice);
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text(Strings.factureAjoutee)),
// // //       );
// // //     } catch (e) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(content: Text('${Strings.erreurReseau}$e')),
// // //       );
// // //     }
// // //   }

// // //   Future<void> _handleFormSubmission(BuildContext context, Facture result) async {
// // //     if (result.id != null) {
// // //       try {
// // //         await Provider.of<InvoiceProvider>(context, listen: false)
// // //             .updateInvoice(result.id!, result);
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text(Strings.factureAjoutee)),
// // //         );
// // //       } catch (e) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('${Strings.erreurReseau}$e')),
// // //         );
// // //       }
// // //     } else {
// // //       try {
// // //         await Provider.of<InvoiceProvider>(context, listen: false)
// // //             .addInvoice(result);
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text(Strings.factureAjoutee)),
// // //         );
// // //       } catch (e) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('${Strings.erreurReseau}$e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   void _handleFormError(BuildContext context, dynamic error) {
// // //     print('Erreur dans _editInvoice: $error');
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(content: Text('${Strings.erreurReseau}$error')),
// // //     );
// // //   }

// // //   // ==================== Main Build ====================

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: _buildAppBar(context),
// // //       body: _buildInvoiceList(context),
// // //       floatingActionButton: _buildFloatingActionButton(context),
// // //     );
// // //   }

// // //   AppBar _buildAppBar(BuildContext context) {
// // //     return AppBar(
// // //       title: Text(
// // //         'Factures',
// // //         style: GoogleFonts.poppins(
// // //           fontWeight: FontWeight.w600,
// // //           color: Colors.white,
// // //         ),
// // //       ),
// // //       actions: [
// // //         _buildFilterDropdown(context),
// // //         _buildRefreshButton(context),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildFilterDropdown(BuildContext context) {
// // //     return Consumer<InvoiceProvider>(
// // //       builder: (context, provider, child) => DropdownButton<String>(
// // //         value: provider.filter,
// // //         items: ['Toutes', 'Annulées', 'Récurrentes']
// // //             .map((f) => DropdownMenuItem(value: f, child: Text(f, style: GoogleFonts.poppins())))
// // //             .toList(),
// // //         onChanged: (v) => provider.setFilter(v!),
// // //         style: GoogleFonts.poppins(color: Colors.white),
// // //         dropdownColor: InvoiceTheme.colors.primary,
// // //         icon: const Icon(Icons.filter_list, color: Colors.white),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildRefreshButton(BuildContext context) {
// // //     return IconButton(
// // //       icon: const Icon(Icons.refresh, color: Colors.white),
// // //       onPressed: () => Provider.of<InvoiceProvider>(context, listen: false).fetchInvoices(),
// // //     );
// // //   }

// // //   Widget _buildFloatingActionButton(BuildContext context) {
// // //     return FloatingActionButton(
// // //       backgroundColor: InvoiceTheme.colors.primary,
// // //       onPressed: () => _editInvoice(
// // //         context,
// // //         Facture(
// // //           id: null,
// // //           numero: '',
// // //           type: FactureType.standard,
// // //           statut: StatutFacture.brouillon,
// // //           dateEmission: DateTime.now(),
// // //           dateEcheance: DateTime.now().add(const Duration(days: 30)),
// // //           clientNom: '',
// // //           lignes: [],
// // //           penalitesRetard: "5000 FCFA + 2% par mois",
// // //           devise: 'XOF',
// // //         ),
// // //       ),
// // //       child: const Icon(Icons.add, color: Colors.white),
// // //     );
// // //   }
// // // }




// // // filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/features/invoicing/screens/invoice_screen.dart

// // import 'package:ComptaFacile/core/constants/strings.dart';
// // // import 'package:ComptaFacile/core/strings.dart';
// // import 'package:ComptaFacile/core/theme/invoice_theme.dart';
// // import 'package:ComptaFacile/features/invoicing/providers/invoice_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:intl/intl.dart';
// // import 'package:ComptaFacile/features/invoicing/screens/invoice_model.dart';
// // import 'package:ComptaFacile/features/invoicing/invoice_card.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:flutter_animate/flutter_animate.dart';

// // extension StringExtension on String {
// //   String capitalize() {
// //     if (isEmpty) return this;
// //     return '${this[0].toUpperCase()}${substring(1)}';
// //   }
// // }

// // class InvoiceScreen extends StatelessWidget {
// //   const InvoiceScreen({Key? key}) : super(key: key);

// //   Widget _buildInvoiceLineFields(
// //       List<LigneFacture> lignes, int index, StateSetter setState, BuildContext context) {
// //     final ligne = lignes[index];
// //     final descriptionController = TextEditingController(text: ligne.description);
// //     final quantiteController = TextEditingController(text: ligne.quantite.toString());
// //     final prixUnitaireController = TextEditingController(text: ligne.prixUnitaire.toString());
// //     final tvaController = TextEditingController(text: ligne.tva.toString());
// //     final remiseController = TextEditingController(text: ligne.remise.toString());

// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 8.0),
// //       child: Column(
// //         children: [
// //           TextField(
// //             controller: descriptionController,
// //             decoration: InputDecoration(
// //               labelText: 'Description*',
// //               labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               filled: true,
// //               fillColor: Colors.grey.shade100,
// //             ),
// //             style: GoogleFonts.poppins(),
// //             onChanged: (value) => ligne.description = value,
// //           ),
// //           const SizedBox(height: 12),
// //           TextField(
// //             controller: quantiteController,
// //             decoration: InputDecoration(
// //               labelText: 'Quantité*',
// //               labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               filled: true,
// //               fillColor: Colors.grey.shade100,
// //             ),
// //             style: GoogleFonts.poppins(),
// //             keyboardType: TextInputType.number,
// //             onChanged: (value) => ligne.quantite = int.tryParse(value) ?? 1,
// //           ),
// //           const SizedBox(height: 12),
// //           TextField(
// //             controller: prixUnitaireController,
// //             decoration: InputDecoration(
// //               labelText: 'Prix Unitaire*',
// //               labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               filled: true,
// //               fillColor: Colors.grey.shade100,
// //             ),
// //             style: GoogleFonts.poppins(),
// //             keyboardType: TextInputType.number,
// //             onChanged: (value) => ligne.prixUnitaire = double.tryParse(value) ?? 0,
// //           ),
// //           const SizedBox(height: 12),
// //           TextField(
// //             controller: tvaController,
// //             decoration: InputDecoration(
// //               labelText: 'TVA (%)*',
// //               labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               filled: true,
// //               fillColor: Colors.grey.shade100,
// //             ),
// //             style: GoogleFonts.poppins(),
// //             keyboardType: TextInputType.number,
// //             onChanged: (value) => ligne.tva = double.tryParse(value) ?? 0,
// //           ),
// //           const SizedBox(height: 12),
// //           TextField(
// //             controller: remiseController,
// //             decoration: InputDecoration(
// //               labelText: 'Remise (%)',
// //               labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               filled: true,
// //               fillColor: Colors.grey.shade100,
// //             ),
// //             style: GoogleFonts.poppins(),
// //             keyboardType: TextInputType.number,
// //             onChanged: (value) => ligne.remise = double.tryParse(value) ?? 0,
// //           ),
// //           const SizedBox(height: 12),
// //           TextButton(
// //             onPressed: () => setState(() => lignes.removeAt(index)),
// //             child: Text(
// //               'Supprimer ligne',
// //               style: GoogleFonts.poppins(
// //                 color: InvoiceTheme.colors.error,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildInvoiceList(BuildContext context) {
// //     return Consumer<InvoiceProvider>(
// //       builder: (context, provider, child) {
// //         if (provider.isLoading) {
// //           return const Center(child: CircularProgressIndicator());
// //         }
// //         if (provider.error != null) {
// //           return Center(child: Text('${Strings.erreurChargement}${provider.error}'));
// //         }
// //         final invoices = provider.filter == 'Annulées'
// //             ? provider.invoices.where((f) => f.statut == StatutFacture.annulee).toList()
// //             : provider.filter == 'Récurrentes'
// //                 ? provider.invoices.where((f) => f.type == FactureType.recurrente || f.parentInvoice != null).toList()
// //                 : provider.invoices;
// //         if (invoices.isEmpty) {
// //           return const Center(child: Text(Strings.aucuneFacture));
// //         }
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(8),
// //           itemCount: invoices.length,
// //           itemBuilder: (context, index) {
// //             final facture = invoices[index];
// //             return InvoiceCard(
// //               facture: facture,
// //               onConvert: facture.type == FactureType.devis &&
// //                       facture.statut != StatutFacture.payee &&
// //                       facture.id != null
// //                   ? () => provider.convertDevis(facture.id!)
// //                   : null,
// //               onCancel: facture.statut != StatutFacture.annulee && facture.id != null
// //                   ? () => _cancelInvoice(context, facture.id!)
// //                   : null,
// //               onDelete: facture.id != null &&
// //                       facture.statut != StatutFacture.payee &&
// //                       facture.statut != StatutFacture.annulee
// //                   ? () => _deleteInvoice(context, facture.id!)
// //                   : null,
// //               onEdit: facture.id != null &&
// //                       facture.statut != StatutFacture.payee &&
// //                       facture.statut != StatutFacture.annulee
// //                   ? () => _editInvoice(context, facture)
// //                   : null,
// //               onStatusChange: null,
// //               onPdf: facture.id != null
// //                   ? () async {
// //                       try {
// //                         final url = await provider.generatePdf(facture.id!);
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(content: Text('${Strings.pdfExporte}$url')),
// //                         );
// //                       } catch (e) {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(content: Text('${Strings.erreurExport}$e')),
// //                         );
// //                       }
// //                     }
// //                   : null,
// //               onTap: () {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(content: Text('Facture ${facture.numero} sélectionnée')),
// //                 );
// //               },
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }

// //   Future<void> _cancelInvoice(BuildContext context, String id) async {
// //     final motifController = TextEditingController();

// //     final confirm = await showDialog<bool>(
// //       context: context,
// //       builder: (context) => Dialog(
// //         backgroundColor: Colors.white,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Text(
// //                 'Annuler facture',
// //                 style: GoogleFonts.poppins(
// //                   fontWeight: FontWeight.w600,
// //                   color: InvoiceTheme.colors.primary,
// //                 ),
// //               ),
// //               const SizedBox(height: 12),
// //               TextField(
// //                 controller: motifController,
// //                 decoration: InputDecoration(
// //                   labelText: 'Motif d’annulation*',
// //                   labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   filled: true,
// //                   fillColor: Colors.grey.shade100,
// //                 ),
// //                 style: GoogleFonts.poppins(),
// //               ),
// //               const SizedBox(height: 16),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.end,
// //                 children: [
// //                   TextButton(
// //                     onPressed: () => Navigator.pop(context, false),
// //                     child: Text(
// //                       'Annuler',
// //                       style: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                     ),
// //                   ),
// //                   TextButton(
// //                     onPressed: () {
// //                       if (motifController.text.isEmpty) {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           const SnackBar(content: Text('Le motif est requis')),
// //                         );
// //                         return;
// //                       }
// //                       Navigator.pop(context, true);
// //                     },
// //                     child: Text(
// //                       'Confirmer',
// //                       style: GoogleFonts.poppins(
// //                         color: InvoiceTheme.colors.success,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );

// //     if (confirm == true) {
// //       try {
// //         await Provider.of<InvoiceProvider>(context, listen: false)
// //             .cancelInvoice(id, motifController.text);
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Facture annulée avec succès')),
// //         );
// //       } catch (e) {
// //         String errorMessage = e.toString();
// //         if (errorMessage.contains('Token requis') || errorMessage.contains('Aucun token')) {
// //           errorMessage = 'Veuillez vous reconnecter pour annuler la facture.';
// //         } else if (errorMessage.contains('payée')) {
// //           errorMessage = 'Cette facture est payée et ne peut pas être annulée.';
// //         } else if (errorMessage.contains('annulée')) {
// //           errorMessage = 'Cette facture est déjà annulée.';
// //         } else {
// //           errorMessage = '${Strings.erreurReseau}$errorMessage';
// //         }
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text(errorMessage)),
// //         );
// //       }
// //     }
// //   }

// //   Future<void> _deleteInvoice(BuildContext context, String id) async {
// //     final confirm = await showDialog<bool>(
// //       context: context,
// //       builder: (context) => Dialog(
// //         backgroundColor: Colors.white,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Text(
// //                 'Supprimer facture',
// //                 style: GoogleFonts.poppins(
// //                   fontWeight: FontWeight.w600,
// //                   color: InvoiceTheme.colors.primary,
// //                 ),
// //               ),
// //               const SizedBox(height: 12),
// //               Text(
// //                 'Êtes-vous sûr de vouloir supprimer cette facture ?',
// //                 style: GoogleFonts.poppins(),
// //               ),
// //               const SizedBox(height: 16),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.end,
// //                 children: [
// //                   TextButton(
// //                     onPressed: () => Navigator.pop(context, false),
// //                     child: Text(
// //                       'Annuler',
// //                       style: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                     ),
// //                   ),
// //                   TextButton(
// //                     onPressed: () => Navigator.pop(context, true),
// //                     child: Text(
// //                       'Supprimer',
// //                       style: GoogleFonts.poppins(
// //                         color: InvoiceTheme.colors.error,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //     if (confirm == true) {
// //       try {
// //         await Provider.of<InvoiceProvider>(context, listen: false).deleteInvoice(id);
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Facture supprimée avec succès')),
// //         );
// //       } catch (e) {
// //         String errorMessage = e.toString();
// //         if (errorMessage.contains('payée') || errorMessage.contains('annulée')) {
// //           errorMessage = 'Erreur : Facture payée ou annulée ne peut pas être supprimée.';
// //         } else {
// //           errorMessage = '${Strings.erreurReseau}$errorMessage';
// //         }
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text(errorMessage)),
// //         );
// //       }
// //     }
// //   }

// //   Future<void> _editInvoice(BuildContext context, Facture facture) async {
// //     print('Démarrage _editInvoice pour facture: ${facture.numero}');
// //     final numeroController = TextEditingController(text: facture.numero);
// //     final clientController = TextEditingController(text: facture.clientNom);
// //     final siretController = TextEditingController(text: facture.siret);
// //     final clientSiretController = TextEditingController(text: facture.clientSiret);
// //     final adresseFournisseurController = TextEditingController(text: facture.adresseFournisseur);
// //     final penalitesRetardController = TextEditingController(text: facture.penalitesRetard);
// //     final deviseController = TextEditingController(text: facture.devise ?? 'XOF');
// //     List<LigneFacture> lignes = List.from(facture.lignes);
// //     FactureType type = facture.type;
// //     String? frequence = facture.frequence;
// //     DateTime? dateFin = facture.dateFin;
// //     String? invoiceRef = facture.invoiceRef;
// //     double acompte = facture.acompte;
// //     String? revisionPrix = facture.revisionPrix;
// //     String? motifAvoir = facture.motifAvoir;
// //     String? creditType = facture.creditType;
// //     DateTime? validiteDevis = facture.validiteDevis;
// //     String? signature = facture.signature;
// //     int currentStep = 0;

// //     try {
// //       print('Construction du Dialog');
// //       final result = await showDialog<Facture>(
// //         context: context,
// //         barrierDismissible: false,
// //         barrierColor: Colors.black.withOpacity(0.5),
// //         builder: (context) {
// //           print('Rendu du Dialog');
// //           return StatefulBuilder(
// //             builder: (context, setState) => Dialog(
// //               backgroundColor: Colors.white,
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //               child: Container(
// //                 width: MediaQuery.of(context).size.width * 0.95,
// //                 height: MediaQuery.of(context).size.height * 0.95,
// //                 padding: const EdgeInsets.all(16),
// //                 child: Column(
// //                   children: [
// //                     Text(
// //                       facture.id == null ? 'Nouvelle facture' : 'Modifier facture',
// //                       style: GoogleFonts.poppins(
// //                         fontSize: 22,
// //                         fontWeight: FontWeight.w600,
// //                         color: InvoiceTheme.colors.primary,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 16),
// //                     Expanded(
// //                       child: SingleChildScrollView(
// //                         physics: const ClampingScrollPhysics(),
// //                         child: Column(
// //                           mainAxisSize: MainAxisSize.min,
// //                           children: [
// //                             Stepper(
// //                               currentStep: currentStep,
// //                               onStepContinue: () {
// //                                 if (currentStep < 2) setState(() => currentStep++);
// //                               },
// //                               onStepCancel: () {
// //                                 if (currentStep > 0) setState(() => currentStep--);
// //                               },
// //                               steps: [
// //                                 Step(
// //                                   title: Text(
// //                                     'Client',
// //                                     style: GoogleFonts.poppins(
// //                                       color: currentStep == 0
// //                                           ? InvoiceTheme.colors.primary
// //                                           : Colors.grey.shade600,
// //                                       fontWeight: FontWeight.w600,
// //                                     ),
// //                                   ),
// //                                   content: Column(
// //                                     children: [
// //                                       TextField(
// //                                         controller: numeroController,
// //                                         decoration: InputDecoration(
// //                                           labelText: 'Numéro*',
// //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                           border: OutlineInputBorder(
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                           filled: true,
// //                                           fillColor: Colors.grey.shade100,
// //                                         ),
// //                                         style: GoogleFonts.poppins(),
// //                                       ),
// //                                       const SizedBox(height: 12),
// //                                       TextField(
// //                                         controller: clientController,
// //                                         decoration: InputDecoration(
// //                                           labelText: 'Client*',
// //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                           border: OutlineInputBorder(
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                           filled: true,
// //                                           fillColor: Colors.grey.shade100,
// //                                         ),
// //                                         style: GoogleFonts.poppins(),
// //                                       ),
// //                                       const SizedBox(height: 12),
// //                                       TextField(
// //                                         controller: siretController,
// //                                         decoration: InputDecoration(
// //                                           labelText: 'SIRET Fournisseur*',
// //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                           border: OutlineInputBorder(
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                           filled: true,
// //                                           fillColor: Colors.grey.shade100,
// //                                         ),
// //                                         style: GoogleFonts.poppins(),
// //                                       ),
// //                                       const SizedBox(height: 12),
// //                                       TextField(
// //                                         controller: clientSiretController,
// //                                         decoration: InputDecoration(
// //                                           labelText: 'SIRET Client',
// //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                           border: OutlineInputBorder(
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                           filled: true,
// //                                           fillColor: Colors.grey.shade100,
// //                                         ),
// //                                         style: GoogleFonts.poppins(),
// //                                       ),
// //                                       const SizedBox(height: 12),
// //                                       TextField(
// //                                         controller: adresseFournisseurController,
// //                                         decoration: InputDecoration(
// //                                           labelText: 'Adresse Fournisseur*',
// //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                           border: OutlineInputBorder(
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                           filled: true,
// //                                           fillColor: Colors.grey.shade100,
// //                                         ),
// //                                         style: GoogleFonts.poppins(),
// //                                       ),
// //                                       const SizedBox(height: 12),
// //                                       TextField(
// //                                         controller: penalitesRetardController,
// //                                         decoration: InputDecoration(
// //                                           labelText: 'Pénalités de retard*',
// //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                           border: OutlineInputBorder(
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                           filled: true,
// //                                           fillColor: Colors.grey.shade100,
// //                                         ),
// //                                         style: GoogleFonts.poppins(),
// //                                       ),
// //                                       const SizedBox(height: 12),
// //                                       DropdownButtonFormField<String>(
// //                                         value: deviseController.text.isEmpty ? 'XOF' : deviseController.text,
// //                                         items: ['XOF', 'EUR', 'USD', 'XAF']
// //                                             .map((d) => DropdownMenuItem(value: d, child: Text(d, style: GoogleFonts.poppins())))
// //                                             .toList(),
// //                                         onChanged: (v) => setState(() => deviseController.text = v!),
// //                                         decoration: InputDecoration(
// //                                           labelText: 'Devise*',
// //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                           border: OutlineInputBorder(
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                           filled: true,
// //                                           fillColor: Colors.grey.shade100,
// //                                         ),
// //                                         style: GoogleFonts.poppins(),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Step(
// //                                   title: Text(
// //                                     'Lignes',
// //                                     style: GoogleFonts.poppins(
// //                                       color: currentStep == 1
// //                                           ? InvoiceTheme.colors.primary
// //                                           : Colors.grey.shade600,
// //                                       fontWeight: FontWeight.w600,
// //                                     ),
// //                                   ),
// //                                   content: Column(
// //                                     children: [
// //                                       ListView.builder(
// //                                         shrinkWrap: true,
// //                                         physics: const NeverScrollableScrollPhysics(),
// //                                         itemCount: lignes.length,
// //                                         itemBuilder: (context, index) {
// //                                           return _buildInvoiceLineFields(lignes, index, setState, context);
// //                                         },
// //                                       ),
// //                                       const SizedBox(height: 12),
// //                                       ElevatedButton(
// //                                         onPressed: () => setState(() => lignes.add(LigneFacture(
// //                                               description: '',
// //                                               quantite: 1,
// //                                               prixUnitaire: 0,
// //                                               tva: 0,
// //                                               remise: 0,
// //                                             ))),
// //                                         style: ElevatedButton.styleFrom(
// //                                           backgroundColor: InvoiceTheme.colors.secondary,
// //                                           shape: RoundedRectangleBorder(
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                         ),
// //                                         child: Text(
// //                                           'Ajouter ligne',
// //                                           style: GoogleFonts.poppins(
// //                                             color: Colors.white,
// //                                             fontWeight: FontWeight.w600,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Step(
// //                                   title: Text(
// //                                     'Options',
// //                                     style: GoogleFonts.poppins(
// //                                       color: currentStep == 2
// //                                           ? InvoiceTheme.colors.primary
// //                                           : Colors.grey.shade600,
// //                                       fontWeight: FontWeight.w600,
// //                                     ),
// //                                   ),
// //                                   content: Column(
// //                                     children: [
// //                                       DropdownButtonFormField<FactureType>(
// //                                         value: type,
// //                                         items: FactureType.values
// //                                             .map((t) => DropdownMenuItem(
// //                                                   value: t,
// //                                                   child: Text(
// //                                                     t.toString().split('.').last.capitalize(),
// //                                                     style: GoogleFonts.poppins(),
// //                                                   ),
// //                                                 ))
// //                                             .toList(),
// //                                         onChanged: (v) => setState(() => type = v!),
// //                                         decoration: InputDecoration(
// //                                           labelText: 'Type*',
// //                                           labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                           border: OutlineInputBorder(
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                           filled: true,
// //                                           fillColor: Colors.grey.shade100,
// //                                         ),
// //                                         style: GoogleFonts.poppins(),
// //                                       ),
// //                                       const SizedBox(height: 12),
// //                                       if (type == FactureType.recurrente) ...[
// //                                         TextField(
// //                                           onChanged: (v) => frequence = v,
// //                                           decoration: InputDecoration(
// //                                             labelText: 'Fréquence* (mensuelle, trimestrielle, annuelle)',
// //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                             border: OutlineInputBorder(
// //                                               borderRadius: BorderRadius.circular(12),
// //                                             ),
// //                                             filled: true,
// //                                             fillColor: Colors.grey.shade100,
// //                                           ),
// //                                           style: GoogleFonts.poppins(),
// //                                           controller: TextEditingController(text: frequence),
// //                                         ),
// //                                         const SizedBox(height: 12),
// //                                         TextField(
// //                                           onChanged: (v) => revisionPrix = v,
// //                                           decoration: InputDecoration(
// //                                             labelText: 'Révision des prix (ex. +2%/an)',
// //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                             border: OutlineInputBorder(
// //                                               borderRadius: BorderRadius.circular(12),
// //                                             ),
// //                                             filled: true,
// //                                             fillColor: Colors.grey.shade100,
// //                                           ),
// //                                           style: GoogleFonts.poppins(),
// //                                           controller: TextEditingController(text: revisionPrix),
// //                                         ),
// //                                         const SizedBox(height: 12),
// //                                         ElevatedButton(
// //                                           onPressed: () async {
// //                                             dateFin = await showDatePicker(
// //                                               context: context,
// //                                               initialDate: dateFin ?? DateTime.now(),
// //                                               firstDate: DateTime.now(),
// //                                               lastDate: DateTime(2030),
// //                                             );
// //                                             setState(() {});
// //                                           },
// //                                           style: ElevatedButton.styleFrom(
// //                                             backgroundColor: InvoiceTheme.colors.primary,
// //                                             shape: RoundedRectangleBorder(
// //                                               borderRadius: BorderRadius.circular(12),
// //                                             ),
// //                                           ),
// //                                           child: Text(
// //                                             'Date de fin*: ${dateFin != null ? DateFormat('dd/MM/yyyy').format(dateFin!) : "Non défini"}',
// //                                             style: GoogleFonts.poppins(
// //                                               color: Colors.white,
// //                                               fontWeight: FontWeight.w600,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                       if (type == FactureType.acompte || type == FactureType.avoir) ...[
// //                                         const SizedBox(height: 12),
// //                                         TextField(
// //                                           onChanged: (v) => invoiceRef = v,
// //                                           decoration: InputDecoration(
// //                                             labelText: 'Référence facture (ID)*',
// //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                             border: OutlineInputBorder(
// //                                               borderRadius: BorderRadius.circular(12),
// //                                             ),
// //                                             filled: true,
// //                                             fillColor: Colors.grey.shade100,
// //                                           ),
// //                                           style: GoogleFonts.poppins(),
// //                                           controller: TextEditingController(text: invoiceRef),
// //                                         ),
// //                                       ],
// //                                       if (type == FactureType.acompte) ...[
// //                                         const SizedBox(height: 12),
// //                                         TextField(
// //                                           onChanged: (v) => acompte = double.tryParse(v) ?? 0,
// //                                           decoration: InputDecoration(
// //                                             labelText: 'Montant acompte*',
// //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                             border: OutlineInputBorder(
// //                                               borderRadius: BorderRadius.circular(12),
// //                                             ),
// //                                             filled: true,
// //                                             fillColor: Colors.grey.shade100,
// //                                           ),
// //                                           style: GoogleFonts.poppins(),
// //                                           keyboardType: TextInputType.number,
// //                                           controller: TextEditingController(text: acompte.toString()),
// //                                         ),
// //                                         const SizedBox(height: 12),
// //                                         ElevatedButton(
// //                                           onPressed: () async {
// //                                             print('Création facture finale');
// //                                             try {
// //                                               final finalInvoice = Facture(
// //                                                 numero: '',
// //                                                 type: FactureType.standard,
// //                                                 statut: StatutFacture.brouillon,
// //                                                 dateEmission: DateTime.now(),
// //                                                 dateEcheance: DateTime.now().add(const Duration(days: 30)),
// //                                                 clientNom: clientController.text,
// //                                                 siret: siretController.text,
// //                                                 clientSiret: clientSiretController.text,
// //                                                 adresseFournisseur: adresseFournisseurController.text,
// //                                                 penalitesRetard: penalitesRetardController.text,
// //                                                 devise: deviseController.text,
// //                                                 lignes: lignes,
// //                                                 acompte: acompte,
// //                                                 invoiceRef: facture.id,
// //                                               );
// //                                               await Provider.of<InvoiceProvider>(context, listen: false).addInvoice(finalInvoice);
// //                                               ScaffoldMessenger.of(context).showSnackBar(
// //                                                 const SnackBar(content: Text(Strings.factureAjoutee)),
// //                                               );
// //                                             } catch (e) {
// //                                               ScaffoldMessenger.of(context).showSnackBar(
// //                                                 SnackBar(content: Text('${Strings.erreurReseau}$e')),
// //                                               );
// //                                             }
// //                                           },
// //                                           style: ElevatedButton.styleFrom(
// //                                             backgroundColor: InvoiceTheme.colors.success,
// //                                             shape: RoundedRectangleBorder(
// //                                               borderRadius: BorderRadius.circular(12),
// //                                             ),
// //                                           ),
// //                                           child: Text(
// //                                             'Créer facture finale',
// //                                             style: GoogleFonts.poppins(
// //                                               color: Colors.white,
// //                                               fontWeight: FontWeight.w600,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                       if (type == FactureType.avoir) ...[
// //                                         const SizedBox(height: 12),
// //                                         TextField(
// //                                           onChanged: (v) => motifAvoir = v,
// //                                           decoration: InputDecoration(
// //                                             labelText: 'Motif de l’avoir*',
// //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                             border: OutlineInputBorder(
// //                                               borderRadius: BorderRadius.circular(12),
// //                                             ),
// //                                             filled: true,
// //                                             fillColor: Colors.grey.shade100,
// //                                           ),
// //                                           style: GoogleFonts.poppins(),
// //                                           controller: TextEditingController(text: motifAvoir),
// //                                         ),
// //                                         const SizedBox(height: 12),
// //                                         DropdownButtonFormField<String>(
// //                                           value: creditType ?? 'credit',
// //                                           items: [
// //                                             DropdownMenuItem(
// //                                               value: 'credit',
// //                                               child: Text('Crédit client', style: GoogleFonts.poppins()),
// //                                             ),
// //                                             DropdownMenuItem(
// //                                               value: 'remboursement',
// //                                               child: Text('Remboursement', style: GoogleFonts.poppins()),
// //                                             ),
// //                                           ],
// //                                           onChanged: (v) => setState(() => creditType = v!),
// //                                           decoration: InputDecoration(
// //                                             labelText: 'Type d’avoir*',
// //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                             border: OutlineInputBorder(
// //                                               borderRadius: BorderRadius.circular(12),
// //                                             ),
// //                                             filled: true,
// //                                             fillColor: Colors.grey.shade100,
// //                                           ),
// //                                           style: GoogleFonts.poppins(),
// //                                         ),
// //                                       ],
// //                                       if (type == FactureType.devis) ...[
// //                                         const SizedBox(height: 12),
// //                                         ElevatedButton(
// //                                           onPressed: () async {
// //                                             validiteDevis = await showDatePicker(
// //                                               context: context,
// //                                               initialDate: validiteDevis ?? DateTime.now().add(const Duration(days: 30)),
// //                                               firstDate: DateTime.now(),
// //                                               lastDate: DateTime(2030),
// //                                             );
// //                                             setState(() {});
// //                                           },
// //                                           style: ElevatedButton.styleFrom(
// //                                             backgroundColor: InvoiceTheme.colors.primary,
// //                                             shape: RoundedRectangleBorder(
// //                                               borderRadius: BorderRadius.circular(12),
// //                                             ),
// //                                           ),
// //                                           child: Text(
// //                                             'Validité*: ${validiteDevis != null ? DateFormat('dd/MM/yyyy').format(validiteDevis!) : "30 jours"}',
// //                                             style: GoogleFonts.poppins(
// //                                               color: Colors.white,
// //                                               fontWeight: FontWeight.w600,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         const SizedBox(height: 12),
// //                                         TextField(
// //                                           onChanged: (v) => signature = v,
// //                                           decoration: InputDecoration(
// //                                             labelText: 'Signature (facultatif)',
// //                                             labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// //                                             border: OutlineInputBorder(
// //                                               borderRadius: BorderRadius.circular(12),
// //                                             ),
// //                                             filled: true,
// //                                             fillColor: Colors.grey.shade100,
// //                                           ),
// //                                           style: GoogleFonts.poppins(),
// //                                           controller: TextEditingController(text: signature),
// //                                         ),
// //                                       ],
// //                                       const SizedBox(height: 12),
// //                                       Container(
// //                                         padding: const EdgeInsets.all(12),
// //                                         decoration: BoxDecoration(
// //                                           color: InvoiceTheme.colors.secondary.withOpacity(0.1),
// //                                           borderRadius: BorderRadius.circular(12),
// //                                         ),
// //                                         child: Text(
// //                                           'Total TTC: ${NumberFormat.currency(symbol: deviseController.text.isEmpty ? "XOF" : deviseController.text).format(lignes.fold(0.0, (sum, l) => sum + l.montantTTC))}',
// //                                           style: GoogleFonts.poppins(
// //                                             fontSize: 16,
// //                                             fontWeight: FontWeight.bold,
// //                                             color: InvoiceTheme.colors.secondary,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                               controlsBuilder: (context, details) => Padding(
// //                                 padding: const EdgeInsets.symmetric(vertical: 12),
// //                                 child: Row(
// //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                   children: [
// //                                     if (details.currentStep > 0)
// //                                       ElevatedButton(
// //                                         onPressed: details.onStepCancel,
// //                                         style: ElevatedButton.styleFrom(
// //                                           backgroundColor: Colors.grey.shade300,
// //                                           shape: RoundedRectangleBorder(
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                         ),
// //                                         child: Text(
// //                                           'Précédent',
// //                                           style: GoogleFonts.poppins(
// //                                             color: Colors.black87,
// //                                             fontWeight: FontWeight.w600,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     if (details.currentStep < 2)
// //                                       ElevatedButton(
// //                                         onPressed: details.onStepContinue,
// //                                         style: ElevatedButton.styleFrom(
// //                                           backgroundColor: InvoiceTheme.colors.primary,
// //                                           shape: RoundedRectangleBorder(
// //                                             borderRadius: BorderRadius.circular(12),
// //                                           ),
// //                                         ),
// //                                         child: Text(
// //                                           'Suivant',
// //                                           style: GoogleFonts.poppins(
// //                                             color: Colors.white,
// //                                             fontWeight: FontWeight.w600,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 16),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.end,
// //                       children: [
// //                         TextButton(
// //                           onPressed: () {
// //                             print('Annulation du formulaire');
// //                             Navigator.pop(context);
// //                           },
// //                           child: Text(
// //                             'Annuler',
// //                             style: GoogleFonts.poppins(
// //                               color: InvoiceTheme.colors.primary,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //                         ),
// //                         const SizedBox(width: 8),
// //                         ElevatedButton(
// //                           onPressed: () {
// //                             print('Validation du formulaire');
// //                             if (clientController.text.isEmpty ||
// //                                 lignes.any((l) => l.description.isEmpty || l.quantite <= 0 || l.prixUnitaire <= 0)) {
// //                               ScaffoldMessenger.of(context).showSnackBar(
// //                                 const SnackBar(content: Text(Strings.champsVides)),
// //                               );
// //                               return;
// //                             }
// //                             if (type == FactureType.recurrente && (frequence?.isEmpty == true || dateFin == null)) {
// //                               ScaffoldMessenger.of(context).showSnackBar(
// //                                 const SnackBar(content: Text('Fréquence et date de fin obligatoires pour récurrente')),
// //                               );
// //                               return;
// //                             }
// //                             if (type == FactureType.acompte && (invoiceRef?.isEmpty == true || acompte <= 0)) {
// //                               ScaffoldMessenger.of(context).showSnackBar(
// //                                 const SnackBar(content: Text('Référence et acompte positif requis')),
// //                               );
// //                               return;
// //                             }
// //                             if (type == FactureType.avoir && (invoiceRef?.isEmpty == true || motifAvoir?.isEmpty == true)) {
// //                               ScaffoldMessenger.of(context).showSnackBar(
// //                                 const SnackBar(content: Text('Référence et motif requis pour avoir')),
// //                               );
// //                               return;
// //                             }
// //                             if (type == FactureType.devis && validiteDevis == null) {
// //                               ScaffoldMessenger.of(context).showSnackBar(
// //                                 const SnackBar(content: Text('Validité obligatoire pour devis')),
// //                               );
// //                               return;
// //                             }
// //                             print('Facture validée: ${numeroController.text}');
// //                             Navigator.pop(
// //                               context,
// //                               Facture(
// //                                 id: facture.id,
// //                                 numero: numeroController.text,
// //                                 type: type,
// //                                 statut: facture.statut,
// //                                 dateEmission: facture.dateEmission,
// //                                 dateEcheance: facture.dateEcheance,
// //                                 clientNom: clientController.text,
// //                                 siret: siretController.text.isEmpty ? null : siretController.text,
// //                                 clientSiret: clientSiretController.text.isEmpty ? null : clientSiretController.text,
// //                                 adresseFournisseur: adresseFournisseurController.text.isEmpty ? null : adresseFournisseurController.text,
// //                                 penalitesRetard: penalitesRetardController.text.isEmpty ? "5000 FCFA + 2% par mois" : penalitesRetardController.text,
// //                                 devise: deviseController.text.isEmpty ? 'XOF' : deviseController.text,
// //                                 lignes: lignes,
// //                                 frequence: frequence,
// //                                 dateFin: dateFin,
// //                                 invoiceRef: invoiceRef,
// //                                 acompte: acompte,
// //                                 revisionPrix: revisionPrix,
// //                                 motifAvoir: motifAvoir,
// //                                 creditType: creditType,
// //                                 validiteDevis: validiteDevis,
// //                                 signature: signature,
// //                               ),
// //                             );
// //                           },
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: InvoiceTheme.colors.success,
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(12),
// //                             ),
// //                           ),
// //                           child: Text(
// //                             'Enregistrer',
// //                             style: GoogleFonts.poppins(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ).animate().fadeIn(duration: 300.ms).scale(),
// //           );
// //         },
// //       );

// //       print('Résultat du showDialog: ${result != null ? result.toJson() : "null"}');
// //       if (result != null) {
// //         print('Résultat du formulaire: ${result.toJson()}');
// //         if (result.id != null) {
// //           try {
// //             await Provider.of<InvoiceProvider>(context, listen: false)
// //                 .updateInvoice(result.id!, result);
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               const SnackBar(content: Text(Strings.factureAjoutee)),
// //             );
// //           } catch (e) {
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               SnackBar(content: Text('${Strings.erreurReseau}$e')),
// //             );
// //           }
// //         } else {
// //           try {
// //             await Provider.of<InvoiceProvider>(context, listen: false)
// //                 .addInvoice(result);
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               const SnackBar(content: Text(Strings.factureAjoutee)),
// //             );
// //           } catch (e) {
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               SnackBar(content: Text('${Strings.erreurReseau}$e')),
// //             );
// //           }
// //         }
// //       } else {
// //         print('Formulaire annulé');
// //       }
// //     } catch (e) {
// //       print('Erreur dans _editInvoice: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('${Strings.erreurReseau}$e')),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           'Factures',
// //           style: GoogleFonts.poppins(
// //             fontWeight: FontWeight.w600,
// //             color: Colors.white,
// //           ),
// //         ),
// //         actions: [
// //           Consumer<InvoiceProvider>(
// //             builder: (context, provider, child) => DropdownButton<String>(
// //               value: provider.filter,
// //               items: ['Toutes', 'Annulées', 'Récurrentes']
// //                   .map((f) => DropdownMenuItem(value: f, child: Text(f, style: GoogleFonts.poppins())))
// //                   .toList(),
// //               onChanged: (v) {
// //                 provider.setFilter(v!);
// //               },
// //               style: GoogleFonts.poppins(color: Colors.white),
// //               dropdownColor: InvoiceTheme.colors.primary,
// //               icon: const Icon(Icons.filter_list, color: Colors.white),
// //             ),
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.refresh, color: Colors.white),
// //             onPressed: () => Provider.of<InvoiceProvider>(context, listen: false).fetchInvoices(),
// //           ),
// //         ],
// //       ),
// //       body: _buildInvoiceList(context),
// //       floatingActionButton: FloatingActionButton(
// //         backgroundColor: InvoiceTheme.colors.primary,
// //         onPressed: () {
// //           print('Bouton plus cliqué');
// //           _editInvoice(
// //             context,
// //             Facture(
// //               id: null,
// //               numero: '',
// //               type: FactureType.standard,
// //               statut: StatutFacture.brouillon,
// //               dateEmission: DateTime.now(),
// //               dateEcheance: DateTime.now().add(const Duration(days: 30)),
// //               clientNom: '',
// //               lignes: [],
// //               penalitesRetard: "5000 FCFA + 2% par mois",
// //               devise: 'XOF',
// //             ),
// //           );
// //         },
// //         child: const Icon(Icons.add, color: Colors.white),
// //       ),
// //     );
// //   }
// // }




// // // // filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/features/invoicing/screens/invoice_screen.dart

// // // import 'package:flutter/material.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:intl/intl.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:ComptaFacile/core/theme/invoice_theme.dart';
// // // import 'package:ComptaFacile/features/invoicing/screens/invoice_model.dart';
// // // import 'package:ComptaFacile/features/invoicing/providers/invoice_provider.dart';
// // // import 'package:ComptaFacile/features/invoicing/invoice_card.dart'; // Importation explicite d'InvoiceCard
// // // import 'package:flutter_animate/flutter_animate.dart';

// // // class Strings {
// // //   static const champsVides = 'Veuillez remplir tous les champs obligatoires';
// // //   static const erreurReseau = 'Erreur réseau: ';
// // //   static const factureAjoutee = 'Facture enregistrée avec succès';
// // // }

// // // extension StringExtension on String {
// // //   String capitalize() {
// // //     return "${this[0].toUpperCase()}${substring(1)}";
// // //   }
// // // }

// // // class InvoiceScreen extends StatelessWidget {
// // //   const InvoiceScreen({Key? key}) : super(key: key);

// // //   Widget _buildInvoiceLineFields(
// // //     List<LigneFacture> lignes,
// // //     int index,
// // //     StateSetter setState,
// // //     BuildContext context,
// // //   ) {
// // //     final ligne = lignes[index];
// // //     final descriptionController = TextEditingController(text: ligne.description);
// // //     final quantiteController = TextEditingController(text: ligne.quantite.toString());
// // //     final prixUnitaireController = TextEditingController(text: ligne.prixUnitaire.toString());
// // //     final tvaController = TextEditingController(text: ligne.tva.toString());
// // //     final remiseController = TextEditingController(text: ligne.remise.toString());

// // //     return Card(
// // //       margin: const EdgeInsets.symmetric(vertical: 8),
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //       child: Padding(
// // //         padding: const EdgeInsets.all(12),
// // //         child: Column(
// // //           children: [
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 Text(
// // //                   'Ligne ${index + 1}',
// // //                   style: GoogleFonts.poppins(
// // //                     fontWeight: FontWeight.w600,
// // //                     color: InvoiceTheme.colors.primary,
// // //                   ),
// // //                 ),
// // //                 IconButton(
// // //                   icon: const Icon(Icons.delete, color: Colors.red),
// // //                   onPressed: () => setState(() => lignes.removeAt(index)),
// // //                 ),
// // //               ],
// // //             ),
// // //             TextFormField(
// // //               controller: descriptionController,
// // //               decoration: InputDecoration(
// // //                 labelText: 'Description*',
// // //                 labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
// // //                 filled: true,
// // //                 fillColor: Colors.grey.shade100,
// // //               ),
// // //               style: GoogleFonts.poppins(color: Colors.black87),
// // //               onChanged: (value) => setState(() => lignes[index] = ligne.copyWith(description: value)),
// // //             ),
// // //             const SizedBox(height: 8),
// // //             Row(
// // //               children: [
// // //                 Expanded(
// // //                   child: TextFormField(
// // //                     controller: quantiteController,
// // //                     decoration: InputDecoration(
// // //                       labelText: 'Quantité*',
// // //                       labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
// // //                       filled: true,
// // //                       fillColor: Colors.grey.shade100,
// // //                     ),
// // //                     keyboardType: TextInputType.number,
// // //                     style: GoogleFonts.poppins(color: Colors.black87),
// // //                     onChanged: (value) => setState(() => lignes[index] = ligne.copyWith(
// // //                           quantite: int.tryParse(value) ?? ligne.quantite,
// // //                         )),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(width: 8),
// // //                 Expanded(
// // //                   child: TextFormField(
// // //                     controller: prixUnitaireController,
// // //                     decoration: InputDecoration(
// // //                       labelText: 'Prix unitaire*',
// // //                       labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
// // //                       filled: true,
// // //                       fillColor: Colors.grey.shade100,
// // //                     ),
// // //                     keyboardType: TextInputType.numberWithOptions(decimal: true),
// // //                     style: GoogleFonts.poppins(color: Colors.black87),
// // //                     onChanged: (value) => setState(() => lignes[index] = ligne.copyWith(
// // //                           prixUnitaire: double.tryParse(value) ?? ligne.prixUnitaire,
// // //                         )),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 8),
// // //             Row(
// // //               children: [
// // //                 Expanded(
// // //                   child: TextFormField(
// // //                     controller: tvaController,
// // //                     decoration: InputDecoration(
// // //                       labelText: 'TVA (%)',
// // //                       labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
// // //                       filled: true,
// // //                       fillColor: Colors.grey.shade100,
// // //                     ),
// // //                     keyboardType: TextInputType.numberWithOptions(decimal: true),
// // //                     style: GoogleFonts.poppins(color: Colors.black87),
// // //                     onChanged: (value) => setState(() => lignes[index] = ligne.copyWith(
// // //                           tva: double.tryParse(value) ?? ligne.tva,
// // //                         )),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(width: 8),
// // //                 Expanded(
// // //                   child: TextFormField(
// // //                     controller: remiseController,
// // //                     decoration: InputDecoration(
// // //                       labelText: 'Remise',
// // //                       labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
// // //                       filled: true,
// // //                       fillColor: Colors.grey.shade100,
// // //                     ),
// // //                     keyboardType: TextInputType.numberWithOptions(decimal: true),
// // //                     style: GoogleFonts.poppins(color: Colors.black87),
// // //                     onChanged: (value) => setState(() => lignes[index] = ligne.copyWith(
// // //                           remise: double.tryParse(value) ?? ligne.remise,
// // //                         )),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildInvoiceList(BuildContext context) {
// // //     return Consumer<InvoiceProvider>(
// // //       builder: (context, provider, child) {
// // //         if (provider.isLoading) {
// // //           return const Center(child: CircularProgressIndicator());
// // //         }
// // //         if (provider.error != null) {
// // //           return Center(
// // //             child: Text(
// // //               provider.error!,
// // //               style: GoogleFonts.poppins(color: InvoiceTheme.colors.error),
// // //             ),
// // //           );
// // //         }
// // //         if (provider.invoices.isEmpty) {
// // //           return Center(
// // //             child: Text(
// // //               'Aucune facture disponible',
// // //               style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600),
// // //             ),
// // //           );
// // //         }
// // //         return RefreshIndicator(
// // //           onRefresh: () => provider.fetchInvoices(),
// // //           child: ListView.builder(
// // //             physics: const AlwaysScrollableScrollPhysics(),
// // //             padding: const EdgeInsets.symmetric(vertical: 8),
// // //             itemCount: provider.invoices.length,
// // //             itemBuilder: (context, index) {
// // //               final facture = provider.invoices[index];
// // //               return InvoiceCard(
// // //                 facture: facture,
// // //                 onEdit: facture.id != null &&
// // //                         facture.statut != StatutFacture.payee &&
// // //                         facture.statut != StatutFacture.annulee
// // //                     ? () => _editInvoice(context, facture)
// // //                     : null,
// // //                 onDelete: facture.id != null &&
// // //                         facture.statut != StatutFacture.payee &&
// // //                         facture.statut != StatutFacture.annulee
// // //                     ? () => _deleteInvoice(context, facture.id!)
// // //                     : null,
// // //                 onCancel: facture.id != null &&
// // //                         facture.statut != StatutFacture.payee &&
// // //                         facture.statut != StatutFacture.annulee
// // //                     ? () => _cancelInvoice(context, facture.id!)
// // //                     : null,
// // //                 onConvert: facture.id != null && facture.type == FactureType.devis
// // //                     ? () async {
// // //                         try {
// // //                           await provider.convertDevis(facture.id!);
// // //                           ScaffoldMessenger.of(context).showSnackBar(
// // //                             const SnackBar(content: Text('Devis converti en facture')),
// // //                           );
// // //                         } catch (e) {
// // //                           ScaffoldMessenger.of(context).showSnackBar(
// // //                             SnackBar(content: Text('Erreur: $e')),
// // //                           );
// // //                         }
// // //                       }
// // //                     : null,
// // //                 onStatusChange: facture.id != null &&
// // //                         facture.statut != StatutFacture.payee &&
// // //                         facture.statut != StatutFacture.annulee
// // //                     ? () => _changeInvoiceStatus(context, facture.id!, facture.statut)
// // //                     : null,
// // //                 onPdf: facture.id != null
// // //                     ? () async {
// // //                         try {
// // //                           final filePath = await provider.generatePdf(facture.id!);
// // //                           if (filePath != null) {
// // //                             ScaffoldMessenger.of(context).showSnackBar(
// // //                               SnackBar(content: Text('PDF généré: $filePath')),
// // //                             );
// // //                           } else {
// // //                             ScaffoldMessenger.of(context).showSnackBar(
// // //                               const SnackBar(content: Text('Erreur lors de la génération du PDF')),
// // //                             );
// // //                           }
// // //                         } catch (e) {
// // //                           ScaffoldMessenger.of(context).showSnackBar(
// // //                             SnackBar(content: Text('Erreur: $e')),
// // //                           );
// // //                         }
// // //                       }
// // //                     : null,
// // //               );
// // //             },
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   Future<void> _cancelInvoice(BuildContext context, String id) async {
// // //     final motifController = TextEditingController();
// // //     final confirm = await showDialog<bool>(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: Text(
// // //           'Annuler la facture',
// // //           style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
// // //         ),
// // //         content: TextFormField(
// // //           controller: motifController,
// // //           decoration: InputDecoration(
// // //             labelText: 'Motif d’annulation*',
// // //             labelStyle: GoogleFonts.poppins(),
// // //             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
// // //           ),
// // //           maxLines: 3,
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(context, false),
// // //             child: Text('Annuler', style: GoogleFonts.poppins()),
// // //           ),
// // //           TextButton(
// // //             onPressed: () {
// // //               if (motifController.text.isEmpty) {
// // //                 ScaffoldMessenger.of(context).showSnackBar(
// // //                   const SnackBar(content: Text('Le motif est requis')),
// // //                 );
// // //                 return;
// // //               }
// // //               Navigator.pop(context, true);
// // //             },
// // //             child: Text(
// // //               'Confirmer',
// // //               style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: InvoiceTheme.colors.error),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );

// // //     if (confirm == true) {
// // //       try {
// // //         await Provider.of<InvoiceProvider>(context, listen: false)
// // //             .cancelInvoice(id, motifController.text);
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Facture annulée')),
// // //         );
// // //       } catch (e) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   Future<void> _deleteInvoice(BuildContext context, String id) async {
// // //     final confirm = await showDialog<bool>(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: Text(
// // //           'Supprimer la facture',
// // //           style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
// // //         ),
// // //         content: Text(
// // //           'Êtes-vous sûr de vouloir supprimer cette facture ?',
// // //           style: GoogleFonts.poppins(),
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(context, false),
// // //             child: Text('Annuler', style: GoogleFonts.poppins()),
// // //           ),
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(context, true),
// // //             child: Text(
// // //               'Supprimer',
// // //               style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: InvoiceTheme.colors.error),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );

// // //     if (confirm == true) {
// // //       try {
// // //         await Provider.of<InvoiceProvider>(context, listen: false).deleteInvoice(id);
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Facture supprimée')),
// // //         );
// // //       } catch (e) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   Future<void> _changeInvoiceStatus(BuildContext context, String invoiceId, StatutFacture currentStatus) async {
// // //     StatutFacture? selectedStatus;

// // //     final availableStatuses = StatutFacture.values
// // //         .where((status) {
// // //           if (currentStatus == StatutFacture.payee || currentStatus == StatutFacture.annulee) {
// // //             return false;
// // //           }
// // //           if (status == currentStatus) {
// // //             return false;
// // //           }
// // //           if (currentStatus == StatutFacture.brouillon &&
// // //               (status == StatutFacture.payee || status == StatutFacture.enRetard)) {
// // //             return false;
// // //           }
// // //           if (currentStatus != StatutFacture.enAttente &&
// // //               (status == StatutFacture.accepte || status == StatutFacture.refuse)) {
// // //             return false;
// // //           }
// // //           return true;
// // //         })
// // //         .toList();

// // //     final confirm = await showDialog<bool>(
// // //       context: context,
// // //       builder: (context) => Dialog(
// // //         backgroundColor: Colors.white,
// // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               Text(
// // //                 'Changer le statut',
// // //                 style: GoogleFonts.poppins(
// // //                   fontWeight: FontWeight.w600,
// // //                   color: InvoiceTheme.colors.primary,
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 12),
// // //               DropdownButtonFormField<StatutFacture>(
// // //                 value: null,
// // //                 items: availableStatuses
// // //                     .map((s) => DropdownMenuItem(
// // //                           value: s,
// // //                           child: Text(
// // //                             StringExtension(s.name).capitalize(),
// // //                             style: GoogleFonts.poppins(color: Colors.black87),
// // //                           ),
// // //                         ))
// // //                     .toList(),
// // //                 onChanged: (value) => selectedStatus = value,
// // //                 decoration: InputDecoration(
// // //                   labelText: 'Nouveau statut*',
// // //                   labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                   filled: true,
// // //                   fillColor: Colors.grey.shade100,
// // //                 ),
// // //                 style: GoogleFonts.poppins(color: Colors.black87),
// // //                 dropdownColor: Colors.grey.shade100,
// // //               ),
// // //               const SizedBox(height: 16),
// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.end,
// // //                 children: [
// // //                   TextButton(
// // //                     onPressed: () => Navigator.pop(context, false),
// // //                     child: Text(
// // //                       'Annuler',
// // //                       style: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                     ),
// // //                   ),
// // //                   TextButton(
// // //                     onPressed: () {
// // //                       if (selectedStatus == null) {
// // //                         ScaffoldMessenger.of(context).showSnackBar(
// // //                           const SnackBar(content: Text('Veuillez sélectionner un statut')),
// // //                         );
// // //                         return;
// // //                       }
// // //                       Navigator.pop(context, true);
// // //                     },
// // //                     child: Text(
// // //                       'Confirmer',
// // //                       style: GoogleFonts.poppins(
// // //                         color: InvoiceTheme.colors.success,
// // //                         fontWeight: FontWeight.w600,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );

// // //     if (confirm == true && selectedStatus != null) {
// // //       try {
// // //         await Provider.of<InvoiceProvider>(context, listen: false)
// // //             .changeInvoiceStatus(invoiceId, selectedStatus!);
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Statut changé en ${StringExtension(selectedStatus!.name).capitalize()}')),
// // //         );
// // //       } catch (e) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   Future<void> _editInvoice(BuildContext context, Facture facture) async {
// // //     Facture editedFacture = facture.copyWith(
// // //       lignes: facture.lignes.map((l) => l.copyWith()).toList(),
// // //     );
// // //     final numeroController = TextEditingController(text: editedFacture.numero);
// // //     final clientController = TextEditingController(text: editedFacture.clientNom);
// // //     final siretController = TextEditingController(text: editedFacture.siret);
// // //     final clientSiretController = TextEditingController(text: editedFacture.clientSiret);
// // //     final adresseFournisseurController = TextEditingController(text: editedFacture.adresseFournisseur);
// // //     final penalitesRetardController = TextEditingController(text: editedFacture.penalitesRetard);
// // //     final deviseController = TextEditingController(text: editedFacture.devise ?? 'XOF');
// // //     final motifAvoirController = TextEditingController(text: editedFacture.motifAvoir);
// // //     final invoiceRefController = TextEditingController(text: editedFacture.invoiceRef);
// // //     final frequenceController = TextEditingController(text: editedFacture.frequence);
// // //     List<LigneFacture> lignes = List.from(editedFacture.lignes);
// // //     DateTime? dateFin = editedFacture.dateFin;
// // //     DateTime? validiteDevis = editedFacture.validiteDevis;
// // //     int currentStep = 0;

// // //     final result = await showDialog<Facture>(
// // //       context: context,
// // //       barrierDismissible: false,
// // //       barrierColor: Colors.black.withOpacity(0.5),
// // //       builder: (context) => StatefulBuilder(
// // //         builder: (context, setState) => Dialog(
// // //           backgroundColor: Colors.white,
// // //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // //           child: ConstrainedBox(
// // //             constraints: BoxConstraints(
// // //               maxHeight: MediaQuery.of(context).size.height * 0.9,
// // //               maxWidth: MediaQuery.of(context).size.width * 0.9,
// // //             ),
// // //             child: Column(
// // //               mainAxisSize: MainAxisSize.min,
// // //               children: [
// // //                 Padding(
// // //                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
// // //                   child: Text(
// // //                     facture.id == null ? 'Nouvelle facture' : 'Modifier facture',
// // //                     style: GoogleFonts.poppins(
// // //                       fontSize: 22,
// // //                       fontWeight: FontWeight.w600,
// // //                       color: InvoiceTheme.colors.primary,
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 Expanded(
// // //                   child: Scrollbar(
// // //                     thumbVisibility: true,
// // //                     interactive: true,
// // //                     thickness: 8,
// // //                     radius: const Radius.circular(4),
// // //                     child: SingleChildScrollView(
// // //                       physics: const ClampingScrollPhysics(),
// // //                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// // //                       child: Stepper(
// // //                         currentStep: currentStep,
// // //                         onStepContinue: () {
// // //                           if (currentStep < 2) setState(() => currentStep++);
// // //                         },
// // //                         onStepCancel: () {
// // //                           if (currentStep > 0) setState(() => currentStep--);
// // //                         },
// // //                         steps: [
// // //                           Step(
// // //                             title: Text(
// // //                               'Client',
// // //                               style: GoogleFonts.poppins(
// // //                                 color: currentStep == 0
// // //                                     ? InvoiceTheme.colors.primary
// // //                                     : Colors.grey.shade600,
// // //                                 fontWeight: FontWeight.w600,
// // //                               ),
// // //                             ),
// // //                             content: Column(
// // //                               children: [
// // //                                 TextFormField(
// // //                                   controller: numeroController,
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Numéro*',
// // //                                     labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                     filled: true,
// // //                                     fillColor: Colors.grey.shade100,
// // //                                   ),
// // //                                   style: GoogleFonts.poppins(color: Colors.black87),
// // //                                   onChanged: (value) => setState(() => editedFacture = editedFacture.copyWith(numero: value)),
// // //                                 ),
// // //                                 const SizedBox(height: 12),
// // //                                 TextFormField(
// // //                                   controller: clientController,
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Client*',
// // //                                     labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                     filled: true,
// // //                                     fillColor: Colors.grey.shade100,
// // //                                   ),
// // //                                   style: GoogleFonts.poppins(color: Colors.black87),
// // //                                   onChanged: (value) => setState(() => editedFacture = editedFacture.copyWith(clientNom: value)),
// // //                                 ),
// // //                                 const SizedBox(height: 12),
// // //                                 TextFormField(
// // //                                   controller: siretController,
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'SIRET',
// // //                                     labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                     filled: true,
// // //                                     fillColor: Colors.grey.shade100,
// // //                                   ),
// // //                                   style: GoogleFonts.poppins(color: Colors.black87),
// // //                                   onChanged: (value) => setState(() => editedFacture = editedFacture.copyWith(siret: value.isEmpty ? null : value)),
// // //                                 ),
// // //                                 const SizedBox(height: 12),
// // //                                 TextFormField(
// // //                                   controller: clientSiretController,
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'SIRET Client',
// // //                                     labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                     filled: true,
// // //                                     fillColor: Colors.grey.shade100,
// // //                                   ),
// // //                                   style: GoogleFonts.poppins(color: Colors.black87),
// // //                                   onChanged: (value) => setState(() => editedFacture = editedFacture.copyWith(clientSiret: value.isEmpty ? null : value)),
// // //                                 ),
// // //                                 const SizedBox(height: 12),
// // //                                 TextFormField(
// // //                                   controller: adresseFournisseurController,
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Adresse Fournisseur',
// // //                                     labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                     filled: true,
// // //                                     fillColor: Colors.grey.shade100,
// // //                                   ),
// // //                                   style: GoogleFonts.poppins(color: Colors.black87),
// // //                                   onChanged: (value) => setState(() => editedFacture = editedFacture.copyWith(adresseFournisseur: value.isEmpty ? null : value)),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                           Step(
// // //                             title: Text(
// // //                               'Lignes',
// // //                               style: GoogleFonts.poppins(
// // //                                 color: currentStep == 1
// // //                                     ? InvoiceTheme.colors.primary
// // //                                     : Colors.grey.shade600,
// // //                                 fontWeight: FontWeight.w600,
// // //                               ),
// // //                             ),
// // //                             content: Column(
// // //                               children: [
// // //                                 ListView.builder(
// // //                                   shrinkWrap: true,
// // //                                   physics: const NeverScrollableScrollPhysics(),
// // //                                   itemCount: lignes.length,
// // //                                   itemBuilder: (context, index) {
// // //                                     return _buildInvoiceLineFields(lignes, index, setState, context);
// // //                                   },
// // //                                 ),
// // //                                 const SizedBox(height: 8),
// // //                                 Align(
// // //                                   alignment: Alignment.centerRight,
// // //                                   child: ElevatedButton(
// // //                                     onPressed: () => setState(() => lignes.add(LigneFacture(
// // //                                           description: '',
// // //                                           quantite: 1,
// // //                                           prixUnitaire: 0,
// // //                                           tva: 0,
// // //                                           remise: 0,
// // //                                         ))),
// // //                                     style: ElevatedButton.styleFrom(
// // //                                       backgroundColor: InvoiceTheme.colors.secondary,
// // //                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //                                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// // //                                     ),
// // //                                     child: Text(
// // //                                       'Ajouter ligne',
// // //                                       style: GoogleFonts.poppins(
// // //                                         color: Colors.white,
// // //                                         fontWeight: FontWeight.w600,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                           Step(
// // //                             title: Text(
// // //                               'Options',
// // //                               style: GoogleFonts.poppins(
// // //                                 color: currentStep == 2
// // //                                     ? InvoiceTheme.colors.primary
// // //                                     : Colors.grey.shade600,
// // //                                 fontWeight: FontWeight.w600,
// // //                               ),
// // //                             ),
// // //                             content: Column(
// // //                               children: [
// // //                                 DropdownButtonFormField<FactureType>(
// // //                                   value: editedFacture.type,
// // //                                   items: FactureType.values
// // //                                       .map((t) => DropdownMenuItem(
// // //                                             value: t,
// // //                                             child: Text(
// // //                                               StringExtension(t.name).capitalize(),
// // //                                               style: GoogleFonts.poppins(color: Colors.black87),
// // //                                             ),
// // //                                           ))
// // //                                       .toList(),
// // //                                   onChanged: (v) => setState(() => editedFacture = editedFacture.copyWith(type: v!)),
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Type*',
// // //                                     labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                     filled: true,
// // //                                     fillColor: Colors.grey.shade100,
// // //                                   ),
// // //                                   style: GoogleFonts.poppins(color: Colors.black87),
// // //                                   dropdownColor: Colors.grey.shade100,
// // //                                 ),
// // //                                 const SizedBox(height: 12),
// // //                                 DropdownButtonFormField<StatutFacture>(
// // //                                   value: editedFacture.statut,
// // //                                   items: StatutFacture.values
// // //                                       .where((s) =>
// // //                                           s != StatutFacture.enRetard &&
// // //                                           (editedFacture.type == FactureType.devis
// // //                                               ? s == StatutFacture.brouillon ||
// // //                                                   s == StatutFacture.enAttente ||
// // //                                                   s == StatutFacture.accepte ||
// // //                                                   s == StatutFacture.refuse
// // //                                               : s == StatutFacture.brouillon ||
// // //                                                   s == StatutFacture.envoyee ||
// // //                                                   s == StatutFacture.payee ||
// // //                                                   s == StatutFacture.annulee))
// // //                                       .map((s) => DropdownMenuItem(
// // //                                             value: s,
// // //                                             child: Text(
// // //                                               StringExtension(s.name).capitalize(),
// // //                                               style: GoogleFonts.poppins(color: Colors.black87),
// // //                                             ),
// // //                                           ))
// // //                                       .toList(),
// // //                                   onChanged: (v) => setState(() => editedFacture = editedFacture.copyWith(statut: v!)),
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Statut*',
// // //                                     labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                     filled: true,
// // //                                     fillColor: Colors.grey.shade100,
// // //                                   ),
// // //                                   style: GoogleFonts.poppins(color: Colors.black87),
// // //                                   dropdownColor: Colors.grey.shade100,
// // //                                 ),
// // //                                 const SizedBox(height: 12),
// // //                                 TextFormField(
// // //                                   controller: penalitesRetardController,
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Pénalités de retard',
// // //                                     labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                     filled: true,
// // //                                     fillColor: Colors.grey.shade100,
// // //                                   ),
// // //                                   style: GoogleFonts.poppins(color: Colors.black87),
// // //                                   onChanged: (value) => setState(() => editedFacture = editedFacture.copyWith(penalitesRetard: value.isEmpty ? "5000 FCFA + 2% par mois" : value)),
// // //                                 ),
// // //                                 const SizedBox(height: 12),
// // //                                 TextFormField(
// // //                                   controller: deviseController,
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Devise',
// // //                                     labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                     filled: true,
// // //                                     fillColor: Colors.grey.shade100,
// // //                                   ),
// // //                                   style: GoogleFonts.poppins(color: Colors.black87),
// // //                                   onChanged: (value) => setState(() => editedFacture = editedFacture.copyWith(devise: value.isEmpty ? 'XOF' : value)),
// // //                                 ),
// // //                                 if (editedFacture.type == FactureType.avoir) ...[
// // //                                   const SizedBox(height: 12),
// // //                                   TextFormField(
// // //                                     controller: motifAvoirController,
// // //                                     decoration: InputDecoration(
// // //                                       labelText: 'Motif de l’avoir*',
// // //                                       labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                       filled: true,
// // //                                       fillColor: Colors.grey.shade100,
// // //                                     ),
// // //                                     style: GoogleFonts.poppins(color: Colors.black87),
// // //                                     onChanged: (value) => setState(() => editedFacture = editedFacture.copyWith(motifAvoir: value.isEmpty ? null : value)),
// // //                                   ),
// // //                                 ],
// // //                                 if (editedFacture.type == FactureType.avoir || editedFacture.type == FactureType.acompte) ...[
// // //                                   const SizedBox(height: 12),
// // //                                   TextFormField(
// // //                                     controller: invoiceRefController,
// // //                                     decoration: InputDecoration(
// // //                                       labelText: 'Référence facture*',
// // //                                       labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                       filled: true,
// // //                                       fillColor: Colors.grey.shade100,
// // //                                     ),
// // //                                     style: GoogleFonts.poppins(color: Colors.black87),
// // //                                     onChanged: (value) => setState(() => editedFacture = editedFacture.copyWith(invoiceRef: value.isEmpty ? null : value)),
// // //                                   ),
// // //                                 ],
// // //                                 if (editedFacture.type == FactureType.recurrente) ...[
// // //                                   const SizedBox(height: 12),
// // //                                   TextFormField(
// // //                                     controller: frequenceController,
// // //                                     decoration: InputDecoration(
// // //                                       labelText: 'Fréquence*',
// // //                                       labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                       filled: true,
// // //                                       fillColor: Colors.grey.shade100,
// // //                                     ),
// // //                                     style: GoogleFonts.poppins(color: Colors.black87),
// // //                                     onChanged: (value) => setState(() => editedFacture = editedFacture.copyWith(frequence: value.isEmpty ? null : value)),
// // //                                   ),
// // //                                   const SizedBox(height: 12),
// // //                                   GestureDetector(
// // //                                     onTap: () async {
// // //                                       final picked = await showDatePicker(
// // //                                         context: context,
// // //                                         initialDate: dateFin ?? DateTime.now(),
// // //                                         firstDate: DateTime.now(),
// // //                                         lastDate: DateTime(2100),
// // //                                       );
// // //                                       if (picked != null) {
// // //                                         setState(() => editedFacture = editedFacture.copyWith(dateFin: picked));
// // //                                       }
// // //                                     },
// // //                                     child: InputDecorator(
// // //                                       decoration: InputDecoration(
// // //                                         labelText: 'Date de fin*',
// // //                                         labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                         filled: true,
// // //                                         fillColor: Colors.grey.shade100,
// // //                                       ),
// // //                                       child: Text(
// // //                                         dateFin != null
// // //                                             ? DateFormat('dd/MM/yyyy').format(dateFin)
// // //                                             : 'Sélectionner',
// // //                                         style: GoogleFonts.poppins(color: Colors.black87),
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                                 if (editedFacture.type == FactureType.devis) ...[
// // //                                   const SizedBox(height: 12),
// // //                                   GestureDetector(
// // //                                     onTap: () async {
// // //                                       final picked = await showDatePicker(
// // //                                         context: context,
// // //                                         initialDate: validiteDevis ?? DateTime.now(),
// // //                                         firstDate: DateTime.now(),
// // //                                         lastDate: DateTime(2100),
// // //                                       );
// // //                                       if (picked != null) {
// // //                                         setState(() => editedFacture = editedFacture.copyWith(validiteDevis: picked));
// // //                                       }
// // //                                     },
// // //                                     child: InputDecorator(
// // //                                       decoration: InputDecoration(
// // //                                         labelText: 'Validité devis*',
// // //                                         labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
// // //                                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
// // //                                         filled: true,
// // //                                         fillColor: Colors.grey.shade100,
// // //                                       ),
// // //                                       child: Text(
// // //                                         validiteDevis != null
// // //                                             ? DateFormat('dd/MM/yyyy').format(validiteDevis)
// // //                                             : 'Sélectionner',
// // //                                         style: GoogleFonts.poppins(color: Colors.black87),
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ],
// // //                                 const SizedBox(height: 12),
// // //                                 Container(
// // //                                   padding: const EdgeInsets.all(12),
// // //                                   decoration: BoxDecoration(
// // //                                     color: InvoiceTheme.colors.secondary.withOpacity(0.1),
// // //                                     borderRadius: BorderRadius.circular(12),
// // //                                   ),
// // //                                   child: Text(
// // //                                     'Total TTC: ${NumberFormat.currency(symbol: deviseController.text.isEmpty ? "XOF" : deviseController.text).format(editedFacture.totalTTC)}',
// // //                                     style: GoogleFonts.poppins(
// // //                                       fontSize: 16,
// // //                                       fontWeight: FontWeight.bold,
// // //                                       color: InvoiceTheme.colors.primary,
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         ],
// // //                         controlsBuilder: (context, details) => Padding(
// // //                           padding: const EdgeInsets.symmetric(vertical: 12),
// // //                           child: Row(
// // //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                             children: [
// // //                               if (details.currentStep > 0)
// // //                                 ElevatedButton.icon(
// // //                                   onPressed: details.onStepCancel,
// // //                                   style: ElevatedButton.styleFrom(
// // //                                     backgroundColor: Colors.grey.shade300,
// // //                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //                                     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// // //                                   ),
// // //                                   icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 18),
// // //                                   label: Text(
// // //                                     'Précédent',
// // //                                     style: GoogleFonts.poppins(
// // //                                       color: Colors.black87,
// // //                                       fontWeight: FontWeight.w600,
// // //                                       fontSize: 14,
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                               if (details.currentStep < 2)
// // //                                 ElevatedButton.icon(
// // //                                   onPressed: details.onStepContinue,
// // //                                   style: ElevatedButton.styleFrom(
// // //                                     backgroundColor: InvoiceTheme.colors.primary,
// // //                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //                                     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// // //                                   ),
// // //                                   icon: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
// // //                                   label: Text(
// // //                                     'Suivant',
// // //                                     style: GoogleFonts.poppins(
// // //                                       color: Colors.white,
// // //                                       fontWeight: FontWeight.w600,
// // //                                       fontSize: 14,
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 Padding(
// // //                   padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
// // //                   child: Row(
// // //                     mainAxisAlignment: MainAxisAlignment.end,
// // //                     children: [
// // //                       TextButton(
// // //                         onPressed: () => Navigator.pop(context),
// // //                         child: Text(
// // //                           'Annuler',
// // //                           style: GoogleFonts.poppins(
// // //                             color: InvoiceTheme.colors.primary,
// // //                             fontWeight: FontWeight.w600,
// // //                           ),
// // //                         ),
// // //                       ),
// // //                       const SizedBox(width: 8),
// // //                       ElevatedButton(
// // //                         onPressed: () {
// // //                           if (clientController.text.isEmpty ||
// // //                               numeroController.text.isEmpty ||
// // //                               lignes.any((l) => l.description.isEmpty || l.quantite <= 0 || l.prixUnitaire <= 0)) {
// // //                             ScaffoldMessenger.of(context).showSnackBar(
// // //                               const SnackBar(content: Text(Strings.champsVides)),
// // //                             );
// // //                             return;
// // //                           }
// // //                           if (editedFacture.statut == StatutFacture.payee && lignes.isEmpty) {
// // //                             ScaffoldMessenger.of(context).showSnackBar(
// // //                               const SnackBar(content: Text('Une facture payée doit avoir au moins une ligne')),
// // //                             );
// // //                             return;
// // //                           }
// // //                           if (editedFacture.type == FactureType.recurrente &&
// // //                               (editedFacture.frequence?.isEmpty == true || editedFacture.dateFin == null)) {
// // //                             ScaffoldMessenger.of(context).showSnackBar(
// // //                               const SnackBar(content: Text('Fréquence et date de fin obligatoires pour récurrente')),
// // //                             );
// // //                             return;
// // //                           }
// // //                           if (editedFacture.type == FactureType.acompte &&
// // //                               (editedFacture.invoiceRef?.isEmpty == true || editedFacture.acompte <= 0)) {
// // //                             ScaffoldMessenger.of(context).showSnackBar(
// // //                               const SnackBar(content: Text('Référence et acompte positif requis')),
// // //                             );
// // //                             return;
// // //                           }
// // //                           if (editedFacture.type == FactureType.avoir &&
// // //                               (editedFacture.invoiceRef?.isEmpty == true || editedFacture.motifAvoir?.isEmpty == true)) {
// // //                             ScaffoldMessenger.of(context).showSnackBar(
// // //                               const SnackBar(content: Text('Référence et motif requis pour avoir')),
// // //                             );
// // //                             return;
// // //                           }
// // //                           if (editedFacture.type == FactureType.devis && editedFacture.validiteDevis == null) {
// // //                             ScaffoldMessenger.of(context).showSnackBar(
// // //                               const SnackBar(content: Text('Validité obligatoire pour devis')),
// // //                             );
// // //                             return;
// // //                           }
// // //                           Navigator.pop(context, editedFacture.copyWith(lignes: lignes));
// // //                         },
// // //                         style: ElevatedButton.styleFrom(
// // //                           backgroundColor: InvoiceTheme.colors.success,
// // //                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// // //                         ),
// // //                         child: Text(
// // //                           'Enregistrer',
// // //                           style: GoogleFonts.poppins(
// // //                             color: Colors.white,
// // //                             fontWeight: FontWeight.w600,
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ).animate().fadeIn(duration: 300.ms).scale(),
// // //       ),
// // //     );

// // //     if (result != null) {
// // //       try {
// // //         final provider = Provider.of<InvoiceProvider>(context, listen: false);
// // //         if (result.id != null) {
// // //           await provider.updateInvoice(result.id!, result);
// // //         } else {
// // //           await provider.addInvoice(result);
// // //         }
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text(Strings.factureAjoutee)),
// // //         );
// // //       } catch (e) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('${Strings.erreurReseau}$e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final provider = Provider.of<InvoiceProvider>(context, listen: false);

// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text(
// // //           'Factures',
// // //           style: GoogleFonts.poppins(
// // //             fontWeight: FontWeight.w600,
// // //             color: InvoiceTheme.colors.primary,
// // //           ),
// // //         ),
// // //         backgroundColor: Colors.blue,
// // //         elevation: 0,
// // //         actions: [
// // //           IconButton(
// // //             icon: const Icon(Icons.filter_list, color: Colors.black87),
// // //             onPressed: () async {
// // //               final filter = await showDialog<String>(
// // //                 context: context,
// // //                 builder: (context) => SimpleDialog(
// // //                   title: Text(
// // //                     'Filtrer les factures',
// // //                     style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
// // //                   ),
// // //                   children: [
// // //                     SimpleDialogOption(
// // //                       onPressed: () => Navigator.pop(context, 'Toutes'),
// // //                       child: Text('Toutes', style: GoogleFonts.poppins()),
// // //                     ),
// // //                     SimpleDialogOption(
// // //                       onPressed: () => Navigator.pop(context, 'brouillon'),
// // //                       child: Text('Brouillon', style: GoogleFonts.poppins()),
// // //                     ),
// // //                     SimpleDialogOption(
// // //                       onPressed: () => Navigator.pop(context, 'envoyee'),
// // //                       child: Text('Envoyée', style: GoogleFonts.poppins()),
// // //                     ),
// // //                     SimpleDialogOption(
// // //                       onPressed: () => Navigator.pop(context, 'payee'),
// // //                       child: Text('Payée', style: GoogleFonts.poppins()),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               );
// // //               if (filter != null) {
// // //                 provider.setFilter(filter);
// // //                 provider.fetchInvoices(statut: filter == 'Toutes' ? null : filter);
// // //               }
// // //             },
// // //           ),
// // //         ],
// // //       ),
// // //       body: _buildInvoiceList(context),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: () => _editInvoice(
// // //           context,
// // //           Facture(
// // //             numero: '',
// // //             type: FactureType.standard,
// // //             statut: StatutFacture.brouillon,
// // //             dateEmission: DateTime.now(),
// // //             dateEcheance: DateTime.now().add(const Duration(days: 30)),
// // //             clientNom: '',
// // //             lignes: [],
// // //           ),
// // //         ),
// // //         backgroundColor: InvoiceTheme.colors.primary,
// // //         child: const Icon(Icons.add, color: Colors.white),
// // //       ),
// // //     );
// // //   }
// // // }

































// filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/features/invoicing/screens/invoice_screen.dart

import 'package:ComptaFacile/core/constants/strings.dart';
import 'package:ComptaFacile/core/theme/invoice_theme.dart';
import 'package:ComptaFacile/features/invoicing/providers/invoice_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:ComptaFacile/features/invoicing/screens/invoice_model.dart';
import 'package:ComptaFacile/features/invoicing/invoice_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  Widget _buildInvoiceLineFields(
      List<LigneFacture> lignes, int index, StateSetter setState, BuildContext context) {
    final ligne = lignes[index];
    final descriptionController = TextEditingController(text: ligne.description);
    final quantiteController = TextEditingController(text: ligne.quantite.toString());
    final prixUnitaireController = TextEditingController(text: ligne.prixUnitaire.toString());
    final tvaController = TextEditingController(text: ligne.tva.toString());
    final remiseController = TextEditingController(text: ligne.remise.toString());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description*',
              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            style: GoogleFonts.poppins(),
            onChanged: (value) => ligne.description = value,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: quantiteController,
            decoration: InputDecoration(
              labelText: 'Quantité*',
              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            style: GoogleFonts.poppins(),
            keyboardType: TextInputType.number,
            onChanged: (value) => ligne.quantite = int.tryParse(value) ?? 1,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: prixUnitaireController,
            decoration: InputDecoration(
              labelText: 'Prix Unitaire*',
              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            style: GoogleFonts.poppins(),
            keyboardType: TextInputType.number,
            onChanged: (value) => ligne.prixUnitaire = double.tryParse(value) ?? 0,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: tvaController,
            decoration: InputDecoration(
              labelText: 'TVA (%)*',
              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            style: GoogleFonts.poppins(),
            keyboardType: TextInputType.number,
            onChanged: (value) => ligne.tva = double.tryParse(value) ?? 0,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: remiseController,
            decoration: InputDecoration(
              labelText: 'Remise (%)',
              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            style: GoogleFonts.poppins(),
            keyboardType: TextInputType.number,
            onChanged: (value) => ligne.remise = double.tryParse(value) ?? 0,
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => setState(() => lignes.removeAt(index)),
            child: Text(
              'Supprimer ligne',
              style: GoogleFonts.poppins(
                color: InvoiceTheme.colors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceList(BuildContext context) {
    return Consumer<InvoiceProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null) {
          return Center(child: Text('${Strings.erreurChargement}${provider.error}'));
        }
        final invoices = provider.filter == 'Annulées'
            ? provider.invoices.where((f) => f.statut == StatutFacture.annulee).toList()
            : provider.filter == 'Récurrentes'
                ? provider.invoices.where((f) => f.type == FactureType.recurrente || f.parentInvoice != null).toList()
                : provider.invoices;
        if (invoices.isEmpty) {
          return const Center(child: Text(Strings.aucuneFacture));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: invoices.length,
          itemBuilder: (context, index) {
            final facture = invoices[index];
            return InvoiceCard(
              facture: facture,
              onConvert: facture.type == FactureType.devis &&
                      facture.statut != StatutFacture.payee &&
                      facture.id != null
                  ? () => provider.convertDevis(facture.id!)
                  : null,
              onCancel: facture.statut != StatutFacture.annulee && facture.id != null
                  ? () => _cancelInvoice(context, facture.id!)
                  : null,
              onDelete: facture.id != null &&
                      facture.statut != StatutFacture.payee &&
                      facture.statut != StatutFacture.annulee
                  ? () => _deleteInvoice(context, facture.id!)
                  : null,
              onEdit: facture.id != null &&
                      facture.statut != StatutFacture.payee &&
                      facture.statut != StatutFacture.annulee
                  ? () => _editInvoice(context, facture)
                  : null,
              onStatusChange: null,
              onPdf: facture.id != null
                  ? () async {
                      try {
                        final url = await provider.generatePdf(facture.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${Strings.pdfExporte}$url')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${Strings.erreurExport}$e')),
                        );
                      }
                    }
                  : null,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Facture ${facture.numero} sélectionnée')),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _cancelInvoice(BuildContext context, String id) async {
    final motifController = TextEditingController();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Annuler facture',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: InvoiceTheme.colors.primary,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: motifController,
                decoration: InputDecoration(
                  labelText: 'Motif d’annulation*',
                  labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      'Annuler',
                      style: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (motifController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Le motif est requis')),
                        );
                        return;
                      }
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      'Confirmer',
                      style: GoogleFonts.poppins(
                        color: InvoiceTheme.colors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirm == true) {
      try {
        await Provider.of<InvoiceProvider>(context, listen: false)
            .cancelInvoice(id, motifController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Facture annulée avec succès')),
        );
      } catch (e) {
        String errorMessage = e.toString();
        if (errorMessage.contains('Token requis') || errorMessage.contains('Aucun token')) {
          errorMessage = 'Veuillez vous reconnecter pour annuler la facture.';
        } else if (errorMessage.contains('payée')) {
          errorMessage = 'Cette facture est payée et ne peut pas être annulée.';
        } else if (errorMessage.contains('annulée')) {
          errorMessage = 'Cette facture est déjà annulée.';
        } else {
          errorMessage = '${Strings.erreurReseau}$errorMessage';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  Future<void> _deleteInvoice(BuildContext context, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Supprimer facture',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: InvoiceTheme.colors.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Êtes-vous sûr de vouloir supprimer cette facture ?',
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      'Annuler',
                      style: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      'Supprimer',
                      style: GoogleFonts.poppins(
                        color: InvoiceTheme.colors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (confirm == true) {
      try {
        await Provider.of<InvoiceProvider>(context, listen: false).deleteInvoice(id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Facture supprimée avec succès')),
        );
      } catch (e) {
        String errorMessage = e.toString();
        if (errorMessage.contains('payée') || errorMessage.contains('annulée')) {
          errorMessage = 'Erreur : Facture payée ou annulée ne peut pas être supprimée.';
        } else {
          errorMessage = '${Strings.erreurReseau}$errorMessage';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  Future<void> _editInvoice(BuildContext context, Facture facture) async {
    print('Démarrage _editInvoice pour facture: ${facture.numero}');
    final numeroController = TextEditingController(text: facture.numero);
    final clientController = TextEditingController(text: facture.clientNom);
    final siretController = TextEditingController(text: facture.siret);
    final clientSiretController = TextEditingController(text: facture.clientSiret);
    final adresseFournisseurController = TextEditingController(text: facture.adresseFournisseur);
    final penalitesRetardController = TextEditingController(text: facture.penalitesRetard);
    final deviseController = TextEditingController(text: facture.devise ?? 'XOF');
    List<LigneFacture> lignes = List.from(facture.lignes);
    FactureType type = facture.type;
    String? frequence = facture.frequence;
    DateTime? dateFin = facture.dateFin;
    String? invoiceRef = facture.invoiceRef;
    double acompte = facture.acompte;
    String? revisionPrix = facture.revisionPrix;
    String? motifAvoir = facture.motifAvoir;
    String? creditType = facture.creditType;
    DateTime? validiteDevis = facture.validiteDevis;
    String? signature = facture.signature;
    int currentStep = 0;

    try {
      print('Construction du Dialog');
      final result = await showDialog<Facture>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (context) {
          print('Rendu du Dialog');
          return StatefulBuilder(
  builder: (context, setState) => Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: ConstrainedBox(  // Ajout d'une contrainte de taille
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        maxWidth: MediaQuery.of(context).size.width * 0.9,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,  // Important pour le dimensionnement
        children: [
                    Text(
                      facture.id == null ? 'Nouvelle facture' : 'Modifier facture',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: InvoiceTheme.colors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        interactive: true,
                        thickness: 8,
                        radius: const Radius.circular(4),
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stepper(
                                currentStep: currentStep,
                                onStepContinue: () {
                                  if (currentStep < 2) setState(() => currentStep++);
                                },
                                onStepCancel: () {
                                  if (currentStep > 0) setState(() => currentStep--);
                                },
                                steps: [
                                  Step(
                                    title: Text(
                                      'Client',
                                      style: GoogleFonts.poppins(
                                        color: currentStep == 0
                                            ? InvoiceTheme.colors.primary
                                            : Colors.grey.shade600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    content: Column(
                                      children: [
                                        TextField(
                                          controller: numeroController,
                                          decoration: InputDecoration(
                                            labelText: 'Numéro*',
                                            labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                          ),
                                          style: GoogleFonts.poppins(),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: clientController,
                                          decoration: InputDecoration(
                                            labelText: 'Client*',
                                            labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                          ),
                                          style: GoogleFonts.poppins(),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: siretController,
                                          decoration: InputDecoration(
                                            labelText: 'SIRET Fournisseur*',
                                            labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                          ),
                                          style: GoogleFonts.poppins(),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: clientSiretController,
                                          decoration: InputDecoration(
                                            labelText: 'SIRET Client',
                                            labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                          ),
                                          style: GoogleFonts.poppins(),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: adresseFournisseurController,
                                          decoration: InputDecoration(
                                            labelText: 'Adresse Fournisseur*',
                                            labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                          ),
                                          style: GoogleFonts.poppins(),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: penalitesRetardController,
                                          decoration: InputDecoration(
                                            labelText: 'Pénalités de retard*',
                                            labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                          ),
                                          style: GoogleFonts.poppins(),
                                        ),
                                        const SizedBox(height: 12),
                                        DropdownButtonFormField<String>(
                                          value: deviseController.text.isEmpty ? 'XOF' : deviseController.text,
                                          items: ['XOF', 'EUR', 'USD', 'XAF']
                                              .map((d) => DropdownMenuItem(
                                                    value: d,
                                                    child: Text(
                                                      d,
                                                      style: GoogleFonts.poppins(color: Colors.black87),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (v) => setState(() => deviseController.text = v!),
                                          decoration: InputDecoration(
                                            labelText: 'Devise*',
                                            labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                          ),
                                          style: GoogleFonts.poppins(color: Colors.black87),
                                          dropdownColor: Colors.grey.shade100,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Step(
                                    title: Text(
                                      'Lignes',
                                      style: GoogleFonts.poppins(
                                        color: currentStep == 1
                                            ? InvoiceTheme.colors.primary
                                            : Colors.grey.shade600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    content: Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: lignes.length,
                                          itemBuilder: (context, index) {
                                            return _buildInvoiceLineFields(lignes, index, setState, context);
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            onPressed: () => setState(() => lignes.add(LigneFacture(
                                                  description: '',
                                                  quantite: 1,
                                                  prixUnitaire: 0,
                                                  tva: 0,
                                                  remise: 0,
                                                ))),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: InvoiceTheme.colors.secondary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: Text(
                                              'Ajouter ligne',
                                              style: GoogleFonts.poppins(
                                                color: Colors.blue.shade900,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Step(
                                    title: Text(
                                      'Options',
                                      style: GoogleFonts.poppins(
                                        color: currentStep == 2
                                            ? InvoiceTheme.colors.primary
                                            : Colors.grey.shade600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    content: Column(
                                      children: [
                                        DropdownButtonFormField<FactureType>(
                                          value: type,
                                          items: FactureType.values
                                              .map((t) => DropdownMenuItem(
                                                    value: t,
                                                    child: Text(
                                                      t.toString().split('.').last.capitalize(),
                                                      style: GoogleFonts.poppins(color: Colors.black87),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (v) => setState(() => type = v!),
                                          decoration: InputDecoration(
                                            labelText: 'Type*',
                                            labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                          ),
                                          style: GoogleFonts.poppins(color: Colors.black87),
                                          dropdownColor: Colors.grey.shade100,
                                        ),
                                        const SizedBox(height: 12),
                                        if (type == FactureType.recurrente) ...[
                                          TextField(
                                            onChanged: (v) => frequence = v,
                                            decoration: InputDecoration(
                                              labelText: 'Fréquence* (mensuelle, trimestrielle, annuelle)',
                                              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey.shade100,
                                            ),
                                            style: GoogleFonts.poppins(),
                                            controller: TextEditingController(text: frequence),
                                          ),
                                          const SizedBox(height: 12),
                                          TextField(
                                            onChanged: (v) => revisionPrix = v,
                                            decoration: InputDecoration(
                                              labelText: 'Révision des prix (ex. +2%/an)',
                                              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey.shade100,
                                            ),
                                            style: GoogleFonts.poppins(),
                                            controller: TextEditingController(text: revisionPrix),
                                          ),
                                          const SizedBox(height: 12),
                                          ElevatedButton(
                                            onPressed: () async {
                                              dateFin = await showDatePicker(
                                                context: context,
                                                initialDate: dateFin ?? DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2030),
                                              );
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: InvoiceTheme.colors.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: Text(
                                              'Date de fin*: ${dateFin != null ? DateFormat('dd/MM/yyyy').format(dateFin!) : "Non défini"}',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                        if (type == FactureType.acompte || type == FactureType.avoir) ...[
                                          const SizedBox(height: 12),
                                          TextField(
                                            onChanged: (v) => invoiceRef = v,
                                            decoration: InputDecoration(
                                              labelText: 'Référence facture (ID)*',
                                              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey.shade100,
                                            ),
                                            style: GoogleFonts.poppins(),
                                            controller: TextEditingController(text: invoiceRef),
                                          ),
                                        ],
                                        if (type == FactureType.acompte) ...[
                                          const SizedBox(height: 12),
                                          TextField(
                                            onChanged: (v) => acompte = double.tryParse(v) ?? 0,
                                            decoration: InputDecoration(
                                              labelText: 'Montant acompte*',
                                              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey.shade100,
                                            ),
                                            style: GoogleFonts.poppins(),
                                            keyboardType: TextInputType.number,
                                            controller: TextEditingController(text: acompte.toString()),
                                          ),
                                          const SizedBox(height: 12),
                                          ElevatedButton(
                                            onPressed: () async {
                                              print('Création facture finale');
                                              try {
                                                final finalInvoice = Facture(
                                                  numero: '',
                                                  type: FactureType.standard,
                                                  statut: StatutFacture.brouillon,
                                                  dateEmission: DateTime.now(),
                                                  dateEcheance: DateTime.now().add(const Duration(days: 30)),
                                                  clientNom: clientController.text,
                                                  siret: siretController.text,
                                                  clientSiret: clientSiretController.text,
                                                  adresseFournisseur: adresseFournisseurController.text,
                                                  penalitesRetard: penalitesRetardController.text,
                                                  devise: deviseController.text,
                                                  lignes: lignes,
                                                  acompte: acompte,
                                                  invoiceRef: facture.id,
                                                );
                                                await Provider.of<InvoiceProvider>(context, listen: false).addInvoice(finalInvoice);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text(Strings.factureAjoutee)),
                                                );
                                              } catch (e) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('${Strings.erreurReseau}$e')),
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: InvoiceTheme.colors.success,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: Text(
                                              'Créer facture finale',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                        if (type == FactureType.avoir) ...[
                                          const SizedBox(height: 12),
                                          TextField(
                                            onChanged: (v) => motifAvoir = v,
                                            decoration: InputDecoration(
                                              labelText: 'Motif de l’avoir*',
                                              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey.shade100,
                                            ),
                                            style: GoogleFonts.poppins(),
                                            controller: TextEditingController(text: motifAvoir),
                                          ),
                                          const SizedBox(height: 12),
                                          DropdownButtonFormField<String>(
                                            value: creditType ?? 'credit',
                                            items: [
                                              DropdownMenuItem(
                                                value: 'credit',
                                                child: Text('Crédit client', style: GoogleFonts.poppins(color: Colors.black87)),
                                              ),
                                              DropdownMenuItem(
                                                value: 'remboursement',
                                                child: Text('Remboursement', style: GoogleFonts.poppins(color: Colors.black87)),
                                              ),
                                            ],
                                            onChanged: (v) => setState(() => creditType = v!),
                                            decoration: InputDecoration(
                                              labelText: 'Type d’avoir*',
                                              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey.shade100,
                                            ),
                                            style: GoogleFonts.poppins(color: Colors.black87),
                                            dropdownColor: Colors.grey.shade100,
                                          ),
                                        ],
                                        if (type == FactureType.devis) ...[
                                          const SizedBox(height: 12),
                                          ElevatedButton(
                                            onPressed: () async {
                                              validiteDevis = await showDatePicker(
                                                context: context,
                                                initialDate: validiteDevis ?? DateTime.now().add(const Duration(days: 30)),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2030),
                                              );
                                              setState(() {});
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: InvoiceTheme.colors.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: Text(
                                              'Validité*: ${validiteDevis != null ? DateFormat('dd/MM/yyyy').format(validiteDevis!) : "30 jours"}',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          TextField(
                                            onChanged: (v) => signature = v,
                                            decoration: InputDecoration(
                                              labelText: 'Signature (facultatif)',
                                              labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              filled: true,
                                              fillColor: Colors.grey.shade100,
                                            ),
                                            style: GoogleFonts.poppins(),
                                            controller: TextEditingController(text: signature),
                                          ),
                                        ],
                                        const SizedBox(height: 12),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: InvoiceTheme.colors.secondary.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            'Total TTC: ${NumberFormat.currency(symbol: deviseController.text.isEmpty ? "XOF" : deviseController.text).format(lignes.fold(0.0, (sum, l) => sum + l.montantTTC))}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: InvoiceTheme.colors.success,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                controlsBuilder: (context, details) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (details.currentStep > 0)
                                        ElevatedButton.icon(
                                          onPressed: details.onStepCancel,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey.shade300,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                            elevation: 2,
                                          ),
                                          icon: const Icon(Icons.arrow_back, color: Colors.black87),
                                          label: Text(
                                            'Précédent',
                                            style: GoogleFonts.poppins(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      if (details.currentStep < 2)
                                        ElevatedButton.icon(
                                          onPressed: details.onStepContinue,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: InvoiceTheme.colors.primary,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                            elevation: 2,
                                            foregroundColor: Colors.white,
                                          ),
                                          icon: const Icon(Icons.arrow_forward, color: Colors.white),
                                          label: Text(
                                            'Suivant',
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            print('Annulation du formulaire');
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Annuler',
                            style: GoogleFonts.poppins(
                              color: InvoiceTheme.colors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            print('Validation du formulaire');
                            if (clientController.text.isEmpty ||
                                lignes.any((l) => l.description.isEmpty || l.quantite <= 0 || l.prixUnitaire <= 0)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(Strings.champsVides)),
                              );
                              return;
                            }
                            if (type == FactureType.recurrente && (frequence?.isEmpty == true || dateFin == null)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Fréquence et date de fin obligatoires pour récurrente')),
                              );
                              return;
                            }
                            if (type == FactureType.acompte && (invoiceRef?.isEmpty == true || acompte <= 0)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Référence et acompte positif requis')),
                              );
                              return;
                            }
                            if (type == FactureType.avoir && (invoiceRef?.isEmpty == true || motifAvoir?.isEmpty == true)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Référence et motif requis pour avoir')),
                              );
                              return;
                            }
                            if (type == FactureType.devis && validiteDevis == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Validité obligatoire pour devis')),
                              );
                              return;
                            }
                            print('Facture validée: ${numeroController.text}');
                            Navigator.pop(
                              context,
                              Facture(
                                id: facture.id,
                                numero: numeroController.text,
                                type: type,
                                statut: facture.statut,
                                dateEmission: facture.dateEmission,
                                dateEcheance: facture.dateEcheance,
                                clientNom: clientController.text,
                                siret: siretController.text.isEmpty ? null : siretController.text,
                                clientSiret: clientSiretController.text.isEmpty ? null : clientSiretController.text,
                                adresseFournisseur: adresseFournisseurController.text.isEmpty ? null : adresseFournisseurController.text,
                                penalitesRetard: penalitesRetardController.text.isEmpty ? "5000 FCFA + 2% par mois" : penalitesRetardController.text,
                                devise: deviseController.text.isEmpty ? 'XOF' : deviseController.text,
                                lignes: lignes,
                                frequence: frequence,
                                dateFin: dateFin,
                                invoiceRef: invoiceRef,
                                acompte: acompte,
                                revisionPrix: revisionPrix,
                                motifAvoir: motifAvoir,
                                creditType: creditType,
                                validiteDevis: validiteDevis,
                                signature: signature,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: InvoiceTheme.colors.success,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Enregistrer',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 300.ms).scale(),
          );
        },
      );

      print('Résultat du showDialog: ${result != null ? result.toJson() : "null"}');
      if (result != null) {
        print('Résultat du formulaire: ${result.toJson()}');
        if (result.id != null) {
          try {
            await Provider.of<InvoiceProvider>(context, listen: false)
                .updateInvoice(result.id!, result);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(Strings.factureAjoutee)),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${Strings.erreurReseau}$e')),
            );
          }
        } else {
          try {
            await Provider.of<InvoiceProvider>(context, listen: false)
                .addInvoice(result);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(Strings.factureAjoutee)),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${Strings.erreurReseau}$e')),
            );
          }
        }
      } else {
        print('Formulaire annulé');
      }
    } catch (e) {
      print('Erreur dans _editInvoice: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${Strings.erreurReseau}$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Factures',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          Consumer<InvoiceProvider>(
            builder: (context, provider, child) => DropdownButton<String>(
              value: provider.filter,
              items: ['Toutes', 'Annulées', 'Récurrentes']
                  .map((f) => DropdownMenuItem(value: f, child: Text(f, style: GoogleFonts.poppins(color: Colors.black87))))
                  .toList(),
              onChanged: (v) {
                provider.setFilter(v!);
              },
              style: GoogleFonts.poppins(color: Colors.white),
              dropdownColor: Colors.grey.shade100,
              icon: const Icon(Icons.filter_list, color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => Provider.of<InvoiceProvider>(context, listen: false).fetchInvoices(),
          ),
        ],
      ),
      body: _buildInvoiceList(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: InvoiceTheme.colors.primary,
        onPressed: () {
          print('Bouton plus cliqué');
          _editInvoice(
            context,
            Facture(
              id: null,
              numero: '',
              type: FactureType.standard,
              statut: StatutFacture.brouillon,
              dateEmission: DateTime.now(),
              dateEcheance: DateTime.now().add(const Duration(days: 30)),
              clientNom: '',
              lignes: [],
              penalitesRetard: "5000 FCFA + 2% par mois",
              devise: 'XOF',
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
