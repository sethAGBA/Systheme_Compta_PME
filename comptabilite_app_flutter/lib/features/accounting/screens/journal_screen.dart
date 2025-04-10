import 'dart:convert';

import 'package:ComptaFacile/core/services/invoice_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/services/journal_service.dart';
import '../../../core/constants/strings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:async';
class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  Timer? _debounce;
  final _descriptionController = TextEditingController();
  final _montantController = TextEditingController();
  final _entiteDebitController = TextEditingController();
  final _entiteCreditController = TextEditingController();
  final _searchController = TextEditingController();
  final _referenceController = TextEditingController();
  final InvoiceService _invoiceService = InvoiceService();
  String? _typeEntiteDebit = 'Banque';
  String? _typeEntiteCredit = 'Fournisseur';
  final List<String> _typeOptions = const [
    'Banque',
    'Fournisseur',
    'Client',
    'Ventes',
  ];
  List<Map<String, dynamic>> _ecritures = [];
  List<Map<String, dynamic>> _invoices = []; // Define _invoices
  List<Map<String, dynamic>> _filteredEcritures = [];
  bool _chargement = false;
  DateTime? _startDate;
  DateTime? _endDate;
  String _sortOption = 'Date croissante';
  final JournalService _journalService = JournalService();

  @override
  void initState() {
    super.initState();
    _chargerEcritures();
    _chargerFactures();
    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), _filterEcritures);
    });
  }
  // Ajouter cette méthode
  Future<void> _chargerFactures() async {
    try {
      final invoices = await _invoiceService.chargerFactures();
      setState(() {
        _invoices = invoices;
      });
    } catch (e) {
      print('Erreur de chargement des factures: $e');
    }
  }

  Future<void> _ajouterEcriture() async {
  if (_descriptionController.text.isEmpty ||
      _montantController.text.isEmpty ||
      _entiteDebitController.text.isEmpty ||
      _entiteCreditController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(Strings.champsVides), backgroundColor: Colors.red.shade400, behavior: SnackBarBehavior.floating),
    );
    return;
  }

  if (!RegExp(r'^\d*\.?\d+$').hasMatch(_montantController.text)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(Strings.montantInvalide), backgroundColor: Colors.red.shade400, behavior: SnackBarBehavior.floating),
    );
    return;
  }

  setState(() => _chargement = true);
  try {
    final ecriture = {
      'description': _descriptionController.text,
      'debitEntityType': _typeEntiteDebit,
      'debitEntityName': _entiteDebitController.text,
      'creditEntityType': _typeEntiteCredit,
      'creditEntityName': _entiteCreditController.text,
      'amount': double.parse(_montantController.text),
      'reference': _referenceController.text.isEmpty ? null : _referenceController.text,
    };
    await _journalService.ajouterEcriture(ecriture);
    await _chargerEcritures();
    _descriptionController.clear();
    _montantController.clear();
    _entiteDebitController.clear();
    _entiteCreditController.clear();
    _referenceController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(Strings.ecritureAjoutee), backgroundColor: Colors.green.shade400, behavior: SnackBarBehavior.floating),
    );
  } catch (e) {
    print('Erreur dans _ajouterEcriture: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${Strings.erreurReseau}$e'), backgroundColor: Colors.red.shade400, behavior: SnackBarBehavior.floating),
    );
  } finally {
    setState(() => _chargement = false);
  }
}
 
 
  Future<void> _chargerEcritures() async {
    setState(() => _chargement = true);
    try {
      final ecritures = await _journalService.chargerEcritures();
      setState(() {
        _ecritures = ecritures;
        _filterEcritures();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${Strings.erreurChargement}$e'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() => _chargement = false);
    }
  }

  // Ajoute cette méthode dans _JournalScreenState
  Future<void> _deleteEcriture(String ecritureId, String description) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Supprimer l’écriture'),
            content: Text(
              'Voulez-vous vraiment supprimer l’écriture "$description" ?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Annuler'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Supprimer', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );

    if (confirm != true) return;

    setState(() => _chargement = true);
    try {
      await _journalService.supprimerEcriture(
        ecritureId,
      ); // Ajoute cette méthode dans JournalService
      setState(() {
        _ecritures.removeWhere((ecr) => ecr['_id'] == ecritureId);
        _filterEcritures();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Écriture supprimée'),
          backgroundColor: Colors.green.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la suppression : $e'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() => _chargement = false);
    }
  }



  Future<void> _editEcriture(Map<String, dynamic> ecriture) async {
  final descriptionController = TextEditingController(text: ecriture['description']?.toString() ?? '');
  final montantController = TextEditingController(text: ecriture['amount']?.toString() ?? '');
  final entiteDebitController = TextEditingController(text: ecriture['debitEntityName']?.toString() ?? '');
  final entiteCreditController = TextEditingController(text: ecriture['creditEntityName']?.toString() ?? '');
  final referenceController = TextEditingController(text: ecriture['reference']?.toString() ?? '');
  String? typeEntiteDebit = ecriture['debitEntityType']?.toString() ?? _typeOptions.first;
  String? typeEntiteCredit = ecriture['creditEntityType']?.toString() ?? _typeOptions.first;

  final updated = await showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Modifier l’écriture "${ecriture['description']}"'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
            DropdownButtonFormField<String>(value: typeEntiteDebit, items: _typeOptions.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(), onChanged: (value) => typeEntiteDebit = value, decoration: InputDecoration(labelText: 'Type Débit')),
            TextField(controller: entiteDebitController, decoration: InputDecoration(labelText: 'Entité Débit')),
            DropdownButtonFormField<String>(value: typeEntiteCredit, items: _typeOptions.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(), onChanged: (value) => typeEntiteCredit = value, decoration: InputDecoration(labelText: 'Type Crédit')),
            TextField(controller: entiteCreditController, decoration: InputDecoration(labelText: 'Entité Crédit')),
            TextField(controller: montantController, decoration: InputDecoration(labelText: 'Montant (FCFA)'), keyboardType: TextInputType.number),
            TextField(controller: referenceController, decoration: InputDecoration(labelText: 'Référence (optionnel)')),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Annuler')),
        TextButton(
          onPressed: () {
            if (descriptionController.text.isEmpty || montantController.text.isEmpty || entiteDebitController.text.isEmpty || entiteCreditController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Strings.champsVides), backgroundColor: Colors.red.shade400));
              return;
            }
            if (!RegExp(r'^\d*\.?\d+$').hasMatch(montantController.text)) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Strings.montantInvalide), backgroundColor: Colors.red.shade400));
              return;
            }
            Navigator.pop(context, {
              'description': descriptionController.text,
              'debitEntityType': typeEntiteDebit,
              'debitEntityName': entiteDebitController.text,
              'creditEntityType': typeEntiteCredit,
              'creditEntityName': entiteCreditController.text,
              'amount': double.parse(montantController.text),
              'reference': referenceController.text.isEmpty ? null : referenceController.text,
              'date': ecriture['date'] ?? DateTime.now().toIso8601String(),
            });
          },
          child: Text('Enregistrer'),
        ),
      ],
    ),
  );

  if (updated == null) return;

  setState(() => _chargement = true);
  try {
    await _journalService.mettreAJourEcriture(ecriture['_id'], updated);
    await _chargerEcritures(); // Recharge les données pour synchronisation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Écriture mise à jour'), backgroundColor: Colors.green.shade400, behavior: SnackBarBehavior.floating),
    );
  } catch (e) {
    print('Erreur dans _editEcriture: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur lors de la mise à jour : $e'), backgroundColor: Colors.red.shade400, behavior: SnackBarBehavior.floating),
    );
  } finally {
    setState(() => _chargement = false);
  }
}

  void _filterEcritures() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredEcritures =
          _ecritures.where((ecriture) {
            bool matchesDate = true;
            if (_startDate != null && _endDate != null) {
              final ecritureDate = DateTime.parse(ecriture['date']);
              matchesDate =
                  ecritureDate.isAfter(_startDate!) &&
                  ecritureDate.isBefore(_endDate!.add(Duration(days: 1)));
            }
            bool matchesText = true;
            if (query.isNotEmpty) {
              matchesText =
                  ecriture['description'].toString().toLowerCase().contains(
                    query,
                  ) ||
                  (ecriture['debitEntityName']
                          ?.toString()
                          .toLowerCase()
                          .contains(query) ??
                      false) ||
                  (ecriture['creditEntityName']
                          ?.toString()
                          .toLowerCase()
                          .contains(query) ??
                      false) ||
                  ecriture['amount'].toString().toLowerCase().contains(query) ||
                  (ecriture['debitEntityType']
                          ?.toString()
                          .toLowerCase()
                          .contains(query) ??
                      false) ||
                  (ecriture['creditEntityType']
                          ?.toString()
                          .toLowerCase()
                          .contains(query) ??
                      false) ||
                  (ecriture['debitAccount']?.toString().toLowerCase().contains(
                        query,
                      ) ??
                      false) ||
                  (ecriture['creditAccount']?.toString().toLowerCase().contains(
                        query,
                      ) ??
                      false);
            }
            return matchesDate && matchesText;
          }).toList();

      switch (_sortOption) {
        case 'Date croissante':
          _filteredEcritures.sort(
            (a, b) =>
                DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])),
          );
          break;
        case 'Date décroissante':
          _filteredEcritures.sort(
            (a, b) =>
                DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])),
          );
          break;
        case 'Montant croissant':
          _filteredEcritures.sort(
            (a, b) => (a['amount'] as num).compareTo(b['amount'] as num),
          );
          break;
        case 'Montant décroissant':
          _filteredEcritures.sort(
            (a, b) => (b['amount'] as num).compareTo(a['amount'] as num),
          );
          break;
      }
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange:
          _startDate != null && _endDate != null
              ? DateTimeRange(start: _startDate!, end: _endDate!)
              : null,
      builder:
          (context, child) => Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.blue.shade700,
              colorScheme: ColorScheme.light(primary: Colors.blue.shade700),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          ),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _filterEcritures();
      });
    }
  }

  Future<void> _exportToPdf() async {
    if (_filteredEcritures.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Strings.aucuneEcriture),
          backgroundColor: Colors.orange.shade400,
        ),
      );
      return;
    }

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build:
            (pw.Context context) => [
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Journal Comptable',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                      style: pw.TextStyle(
                        fontSize: 14,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                columnWidths: {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(2),
                  2: pw.FlexColumnWidth(2.5),
                  3: pw.FlexColumnWidth(2.5),
                  4: pw.FlexColumnWidth(2),
                  5: pw.FlexColumnWidth(2),
                },
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.grey200),
                    children:
                        [
                              'Description',
                              'Date',
                              'Débit',
                              'Crédit',
                              'Montant (FCFA)',
                              'Référence',
                            ]
                            .map(
                              (text) => pw.Padding(
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  text,
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                            )
                            .toList(),
                  ),
                  ..._filteredEcritures.map((ecriture) {
                    final date = DateTime.parse(ecriture['date']).toLocal();
                    final debit =
                        ecriture.containsKey('debitEntityType') &&
                                ecriture['debitEntityType'] != null
                            ? '${ecriture['debitEntityType']} (${ecriture['debitEntityName']})'
                            : ecriture['debitAccount'] ?? 'N/A';
                    final credit =
                        ecriture.containsKey('creditEntityType') &&
                                ecriture['creditEntityType'] != null
                            ? '${ecriture['creditEntityType']} (${ecriture['creditEntityName']})'
                            : ecriture['creditAccount'] ?? 'N/A';

                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(ecriture['description'] ?? 'N/A'),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            DateFormat('dd/MM/yyyy').format(date),
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(debit),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(credit),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            NumberFormat('#,###').format(ecriture['amount']),
                            textAlign: pw.TextAlign.right,
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            ecriture['reference']?.toString() ?? '-',
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Total: ${NumberFormat('#,###').format(_filteredEcritures.fold(0.0, (sum, item) => sum + (item['amount'] as num)))} FCFA',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
      ),
    );

    try {
      final file = File(
        '/storage/emulated/0/Documents/journal_comptable_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.parent.create(recursive: true);
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF exporté dans Documents'),
          backgroundColor: Colors.green.shade400,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Partager',
            textColor: Colors.white,
            onPressed:
                () => Share.shareXFiles([
                  XFile(file.path),
                ], text: 'Voici le journal comptable en PDF'),
          ),
        ),
      );
    } catch (e) {
      print('Erreur d\'export PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${Strings.erreurExport}$e'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  //
  Future<bool> _requestStoragePermission() async {
    // Vérifier si on est sur Android
    if (!Platform.isAndroid) {
      return true; // Pas besoin de permission sur iOS
    }

    // Obtenir la version Android
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    if (sdkInt >= 33) {
      // Android 13 et plus
      final status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Permission de gestion du stockage refusée'),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Paramètres',
              textColor: Colors.white,
              onPressed: () => openAppSettings(),
            ),
          ),
        );
        return false;
      }
    } else {
      // Android 12 et moins
      final status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Permission de stockage refusée'),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Paramètres',
              textColor: Colors.white,
              onPressed: () => openAppSettings(),
            ),
          ),
        );
        return false;
      }
    }
  }

  Future<void> _exportToCsv() async {
    if (_filteredEcritures.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Strings.aucuneEcriture),
          backgroundColor: Colors.orange.shade400,
        ),
      );
      return;
    }

    try {
      String csvContent =
          'Description,Date,Débit,Crédit,Montant (FCFA),Référence\n';

      for (var ecriture in _filteredEcritures) {
        final date = DateTime.parse(ecriture['date']).toLocal();
        final debit = (ecriture.containsKey('debitEntityType') &&
                    ecriture['debitEntityType'] != null
                ? '${ecriture['debitEntityType']} (${ecriture['debitEntityName']})'
                : ecriture['debitAccount'] ?? 'N/A')
            .replaceAll(',', ' ');
        final credit = (ecriture.containsKey('creditEntityType') &&
                    ecriture['creditEntityType'] != null
                ? '${ecriture['creditEntityType']} (${ecriture['creditEntityName']})'
                : ecriture['creditAccount'] ?? 'N/A')
            .replaceAll(',', ' ');

        csvContent +=
            '"${ecriture['description']}",' +
            '"${DateFormat('dd/MM/yyyy').format(date)}",' +
            '"$debit",' +
            '"$credit",' +
            '"${NumberFormat('#,###').format(ecriture['amount'])}",' +
            '"${ecriture['reference'] ?? '-'}"\n';
      }

      final total = _filteredEcritures.fold(
        0.0,
        (sum, item) => sum + (item['amount'] as num),
      );
      csvContent += ',,,,Total,${NumberFormat('#,###').format(total)} FCFA\n';

      final file = File(
        '/storage/emulated/0/Documents/journal_comptable_${DateTime.now().millisecondsSinceEpoch}.csv',
      );
      await file.parent.create(recursive: true);
      await file.writeAsString(csvContent, encoding: utf8);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('CSV exporté dans Documents'),
          backgroundColor: Colors.green.shade400,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Partager',
            textColor: Colors.white,
            onPressed:
                () => Share.shareXFiles([
                  XFile(file.path),
                ], text: 'Voici le journal comptable en CSV'),
          ),
        ),
      );
    } catch (e) {
      print('Erreur d\'export CSV: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${Strings.erreurExport}$e'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journal Comptable',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: Colors.white),
            onPressed: _exportToPdf,
            tooltip: 'Exporter en PDF',
          ),
          IconButton(
            icon: Icon(Icons.table_chart, color: Colors.white),
            onPressed: _exportToCsv,
            tooltip: 'Exporter en CSV',
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade50, Colors.white],
            ),
          ),
          child: LayoutBuilder(
            builder:
                (context, constraints) => RefreshIndicator(
                  onRefresh: _chargerEcritures,
                  color: Colors.blue.shade700,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 8,
                              shadowColor: Colors.blue.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [Colors.white, Colors.blue.shade50],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nouvelle Écriture',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue.shade800,
                                      ),
                                    ).animate().fadeIn(),
                                    SizedBox(height: 20),
                                    _buildTextField(
                                      controller: _descriptionController,
                                      label: 'Description',
                                      icon: Icons.description,
                                    ),
                                    SizedBox(height: 16),
                                    _buildEntitySection(
                                      title: 'Information Débit',
                                      typeValue: _typeEntiteDebit,
                                      typeOnChanged:
                                          (value) => setState(
                                            () => _typeEntiteDebit = value,
                                          ),
                                      controller: _entiteDebitController,
                                      label: 'Entité Débit',
                                    ),
                                    SizedBox(height: 16),
                                    _buildEntitySection(
                                      title: 'Information Crédit',
                                      typeValue: _typeEntiteCredit,
                                      typeOnChanged:
                                          (value) => setState(
                                            () => _typeEntiteCredit = value,
                                          ),
                                      controller: _entiteCreditController,
                                      label: 'Entité Crédit',
                                    ),
                                    SizedBox(height: 16),
                                    _buildTextField(
                                      controller: _montantController,
                                      label: 'Montant (FCFA)',
                                      icon: Icons.attach_money,
                                      keyboardType: TextInputType.number,
                                    ),
                                    SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed:
                                              _chargement
                                                  ? null
                                                  : _ajouterEcriture,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.blue.shade700,
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 32,
                                              vertical: 16,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 4,
                                          ),
                                          icon: Icon(Icons.add),
                                          label: Text(
                                            'Ajouter',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        OutlinedButton.icon(
                                          onPressed:
                                              () => Navigator.pop(context),
                                          style: OutlinedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 32,
                                              vertical: 16,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          icon: Icon(Icons.close),
                                          label: Text(
                                            'Annuler',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ).animate().fadeIn().slideY(),
                            SizedBox(height: 24),

                            // Dans la méthode build, juste avant _buildSearchAndFilter().animate().fadeIn()
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    // Première ligne pour le total des factures
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Factures: ${_invoices.length}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    // Deuxième ligne pour les factures payées
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Payées:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.green.shade700,
                                          ),
                                        ),
                                        Text(
                                          '${NumberFormat('#,###').format(_invoices.where((inv) => inv['status'] == 'paid').fold(0.0, (sum, item) => sum + (item['amount'] as num)))} FCFA',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.green.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Troisième ligne pour les factures impayées
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Impayées:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.orange.shade700,
                                          ),
                                        ),
                                        Text(
                                          '${NumberFormat('#,###').format(_invoices.where((inv) => inv['status'] == 'unpaid').fold(0.0, (sum, item) => sum + (item['amount'] as num)))} FCFA',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.orange.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(height: 16),
                                    // Dernière ligne pour le total général
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue.shade700,
                                          ),
                                        ),
                                        Text(
                                          '${NumberFormat('#,###').format(_invoices.fold(0.0, (sum, item) => sum + (item['amount'] as num)))} FCFA',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ).animate().fadeIn(),
                            SizedBox(height: 16),

                            // Dans la méthode build, juste avant _buildSearchAndFilter().animate().fadeIn()
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    // Première ligne pour le total des écritures
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Écritures: ${_filteredEcritures.length}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    // Deuxième ligne pour le débit
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Débit:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.green.shade700,
                                          ),
                                        ),
                                        Text(
                                          '${NumberFormat('#,###').format(_filteredEcritures.fold(0.0, (sum, item) => item['debitEntityType'] != null ? sum + (item['amount'] as num) : sum))} FCFA',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.green.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Troisième ligne pour le crédit
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Crédit:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.orange.shade700,
                                          ),
                                        ),
                                        Text(
                                          '${NumberFormat('#,###').format(_filteredEcritures.fold(0.0, (sum, item) => item['creditEntityType'] != null ? sum + (item['amount'] as num) : sum))} FCFA',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.orange.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(height: 16),
                                    // Dernière ligne pour le total général
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue.shade700,
                                          ),
                                        ),
                                        Text(
                                          '${NumberFormat('#,###').format(_filteredEcritures.fold(0.0, (sum, item) => sum + (item['amount'] as num)))} FCFA',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ).animate().fadeIn(),

                            SizedBox(height: 16),
                            _buildSearchAndFilter().animate().fadeIn(),
                            SizedBox(height: 16),
                            Container(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade100.withOpacity(
                                      0.2,
                                    ),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child:
                                  _chargement
                                      ? Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.blue.shade700,
                                              ),
                                        ),
                                      )
                                      : _filteredEcritures.isEmpty
                                      ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.note_alt_outlined,
                                              size: 80,
                                              color: Colors.blue.shade200,
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              'Aucune écriture',
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                color: Colors.blue.shade300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).animate().fadeIn()
                                      : _buildEcrituresList(),
                            ).animate().fadeIn().slideY(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(),
        prefixIcon: Icon(icon, color: Colors.blue.shade700),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
        ),
      ),
    ).animate().fadeIn().slideX();
  }

  Widget _buildEntitySection({
    required String title,
    required String? typeValue,
    required ValueChanged<String?> typeOnChanged,
    required TextEditingController controller,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade800,
            ),
          ),
          SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: typeValue,
            items:
                _typeOptions
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
            onChanged: typeOnChanged,
            decoration: InputDecoration(
              labelText: 'Type',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.blue.shade50,
            ),
          ),
          SizedBox(height: 12),
          _buildTextField(
            controller: controller,
            label: label,
            icon: Icons.business,
          ),
        ],
      ),
    ).animate().fadeIn().slideX();
  }

  Widget _buildSearchAndFilter() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildTextField(
              controller: _searchController,
              label: 'Rechercher (description ou entité)',
              icon: Icons.search,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _startDate != null && _endDate != null
                        ? 'Période: ${_startDate!.day}/${_startDate!.month}/${_startDate!.year} - ${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                        : 'Filtrer par date',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.blue.shade700),
                  onPressed: () => _selectDateRange(context),
                ),
              ],
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _sortOption,
              items: const [
                DropdownMenuItem(
                  value: 'Date croissante',
                  child: Text('Date croissante'),
                ),
                DropdownMenuItem(
                  value: 'Date décroissante',
                  child: Text('Date décroissante'),
                ),
                DropdownMenuItem(
                  value: 'Montant croissant',
                  child: Text('Montant croissant'),
                ),
                DropdownMenuItem(
                  value: 'Montant décroissant',
                  child: Text('Montant décroissant'),
                ),
              ],
              onChanged:
                  (value) => setState(() {
                    _sortOption = value!;
                    _filterEcritures();
                  }),
              decoration: InputDecoration(
                labelText: 'Trier par',
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEcrituresList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: _filteredEcritures.length,
      itemBuilder: (context, index) {
        final ecriture = _filteredEcritures[index];
        final date = DateTime.parse(ecriture['date']).toLocal();

        // Gestion améliorée du débit
        final debit =
            ecriture['debitEntityType'] != null
                ? '${ecriture['debitEntityType']} (${ecriture['debitEntityName']})'
                : ecriture['debitAccount'] ?? 'N/A';

        // Gestion améliorée du crédit
        final credit =
            ecriture['creditEntityType'] != null
                ? '${ecriture['creditEntityType']} (${ecriture['creditEntityName']})'
                : ecriture['creditAccount'] ?? 'N/A';

        return Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue.shade50.withOpacity(0.3)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.blue.shade100.withOpacity(0.5),
              width: 0.5,
            ),
          ),
          child: ExpansionTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue.shade100,
              child: Icon(
                Icons.receipt_long,
                color: Colors.blue.shade800,
                size: 25,
              ),
            ),
            title: Text(
              ecriture['description'] ?? 'Sans description',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date: ${date.day}/${date.month}/${date.year}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${NumberFormat('#,###').format(ecriture['amount'])} FCFA',
                  style: GoogleFonts.poppins(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Vérification renforcée pour la référence
                if (ecriture['reference'] != null &&
                    ecriture['reference'].toString().trim().isNotEmpty) ...[
                  SizedBox(height: 4),
                  Text(
                    'Ref: ${ecriture['reference']}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue.shade400, size: 25),
                  onPressed: () => _editEcriture(ecriture),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red.shade400,
                    size: 25,
                  ),
                  onPressed:
                      () => _deleteEcriture(
                        ecriture['_id'],
                        ecriture['description'] ?? 'Sans description',
                      ),
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Débit: $debit',
                            style: GoogleFonts.poppins(color: Colors.green),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.arrow_downward, color: Colors.red, size: 16),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Crédit: $credit',
                            style: GoogleFonts.poppins(color: Colors.red),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn().slideX();
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _descriptionController.dispose();
    _montantController.dispose();
    _entiteDebitController.dispose();
    _entiteCreditController.dispose();
    _referenceController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
