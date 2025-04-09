import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/services/invoice_service.dart';
import '../../../core/constants/strings.dart';

class InvoiceScreen extends StatefulWidget {
  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final _numberController = TextEditingController();
  final _clientNameController = TextEditingController();
  final _amountController = TextEditingController();
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _invoices = [];
  List<Map<String, dynamic>> _filteredInvoices = [];
  bool _isLoading = false;
  DateTime? _startDate;
  DateTime? _endDate;
  String _sortOption = 'Date croissante';
  final InvoiceService _invoiceService = InvoiceService();

  @override
  void initState() {
    super.initState();
    _fetchInvoices();
    _searchController.addListener(_filterInvoices);
  }

  Future<void> _fetchInvoices() async {
    setState(() => _isLoading = true);
    try {
      final invoices = await _invoiceService.chargerFactures();
      setState(() {
        _invoices = invoices;
        _filterInvoices();
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
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createInvoice() async {
    if (_numberController.text.isEmpty ||
        _clientNameController.text.isEmpty ||
        _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Strings.champsVides),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (!RegExp(r'^\d*\.?\d+$').hasMatch(_amountController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Strings.montantInvalide),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _invoiceService.ajouterFacture({
        'number': _numberController.text,
        'clientName': _clientNameController.text,
        'amount': double.parse(_amountController.text),
      });
      setState(() {
        _invoices.add({
          'number': _numberController.text,
          'clientName': _clientNameController.text,
          'amount': double.parse(_amountController.text),
          'status': 'unpaid',
          'createdAt': DateTime.now().toIso8601String(),
        });
        _filterInvoices();
      });
      _numberController.clear();
      _clientNameController.clear();
      _amountController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Strings.factureAjoutee),
          backgroundColor: Colors.green.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${Strings.erreurReseau}$e'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateInvoiceStatus(
    String invoiceId,
    String currentStatus,
  ) async {
    final newStatus = currentStatus == 'paid' ? 'unpaid' : 'paid';
    setState(() => _isLoading = true);
    try {
      await _invoiceService.mettreAJourStatut(invoiceId, newStatus);
      setState(() {
        final index = _invoices.indexWhere((inv) => inv['_id'] == invoiceId);
        if (index != -1) {
          _invoices[index]['status'] = newStatus;
          _filterInvoices();
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${Strings.erreurReseau}$e'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _filterInvoices() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredInvoices =
          _invoices.where((invoice) {
            final invoiceDate = DateTime.parse(invoice['createdAt']);
            final matchesDate =
                (_startDate == null || invoiceDate.isAfter(_startDate!)) &&
                (_endDate == null ||
                    invoiceDate.isBefore(_endDate!.add(Duration(days: 1))));
            final matchesText =
                invoice['number'].toLowerCase().contains(query) ||
                invoice['clientName'].toLowerCase().contains(query);
            return matchesDate && (query.isEmpty || matchesText);
          }).toList();

      switch (_sortOption) {
        case 'Date croissante':
          _filteredInvoices.sort(
            (a, b) => DateTime.parse(
              a['createdAt'],
            ).compareTo(DateTime.parse(b['createdAt'])),
          );
          break;
        case 'Date décroissante':
          _filteredInvoices.sort(
            (a, b) => DateTime.parse(
              b['createdAt'],
            ).compareTo(DateTime.parse(a['createdAt'])),
          );
          break;
        case 'Montant croissant':
          _filteredInvoices.sort(
            (a, b) => (a['amount'] as num).compareTo(b['amount'] as num),
          );
          break;
        case 'Montant décroissant':
          _filteredInvoices.sort(
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
        _filterInvoices();
      });
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid && await Permission.storage.isDenied) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Permission de stockage refusée'),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return false;
      }
    }
    return true; // Pas besoin de permission sur Android 11+ pour "Documents" ou sur iOS
  }

  Future<void> _exportToPdf() async {
    if (_filteredInvoices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Strings.aucuneFacture),
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
                      'Liste des Factures',
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
                  0: pw.FlexColumnWidth(2),
                  1: pw.FlexColumnWidth(3),
                  2: pw.FlexColumnWidth(2),
                  3: pw.FlexColumnWidth(2),
                  4: pw.FlexColumnWidth(1.5),
                },
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.grey200),
                    children:
                        ['Numéro', 'Client', 'Date', 'Montant (FCFA)', 'Statut']
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
                  ..._filteredInvoices.map((invoice) {
                    final date = DateTime.parse(invoice['createdAt']).toLocal();
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            invoice['number'],
                            textAlign: pw.TextAlign.center,
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(invoice['clientName']),
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
                          child: pw.Text(
                            NumberFormat('#,###').format(invoice['amount']),
                            textAlign: pw.TextAlign.right,
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            invoice['status'] == 'paid' ? 'Payée' : 'Impayée',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              color:
                                  invoice['status'] == 'paid'
                                      ? PdfColors.green700
                                      : PdfColors.orange700,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Total: ${NumberFormat('#,###').format(_filteredInvoices.fold(0.0, (sum, item) => sum + (item['amount'] as num)))} FCFA',
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
        '/storage/emulated/0/Documents/factures_${DateTime.now().millisecondsSinceEpoch}.pdf',
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
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
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

  Future<void> _exportToCsv() async {
    if (_filteredInvoices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Strings.aucuneFacture),
          backgroundColor: Colors.orange.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    try {
      String csvContent = 'Numéro,Client,Date,Montant (FCFA),Statut\n';

      for (var invoice in _filteredInvoices) {
        final date = DateTime.parse(invoice['createdAt']).toLocal();
        final clientName = invoice['clientName'].toString().replaceAll(
          ',',
          ' ',
        );

        csvContent +=
            '"${invoice['number']}",' +
            '"$clientName",' +
            '"${DateFormat('dd/MM/yyyy').format(date)}",' +
            '"${NumberFormat('#,###').format(invoice['amount'])}",' +
            '"${invoice['status'] == 'paid' ? 'Payée' : 'Impayée'}"\n';
      }

      final total = _filteredInvoices.fold(
        0.0,
        (sum, item) => sum + (item['amount'] as num),
      );
      csvContent += ',,,Total,${NumberFormat('#,###').format(total)} FCFA\n';

      final file = File(
        '/storage/emulated/0/Documents/factures_${DateTime.now().millisecondsSinceEpoch}.csv',
      );
      await file.parent.create(recursive: true);
      await file.writeAsBytes(utf8.encode(csvContent));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('CSV exporté dans Documents'),
          backgroundColor: Colors.green.shade400,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gestion des Factures',
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
                  onRefresh: _fetchInvoices,
                  color: Colors.blue.shade700,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Card(
                              elevation: 8,
                              shadowColor: Colors.blue.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                width: double.infinity,
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
                                      'Nouvelle Facture',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue.shade800,
                                      ),
                                    ).animate().fadeIn(),
                                    SizedBox(height: 20),
                                    _buildTextField(
                                      controller: _numberController,
                                      label: 'Numéro de facture',
                                      icon: Icons.receipt_long,
                                    ),
                                    SizedBox(height: 16),
                                    _buildTextField(
                                      controller: _clientNameController,
                                      label: 'Nom du client',
                                      icon: Icons.person,
                                    ),
                                    SizedBox(height: 16),
                                    _buildTextField(
                                      controller: _amountController,
                                      label: 'Montant (FCFA)',
                                      icon: Icons.attach_money,
                                      keyboardType: TextInputType.number,
                                    ),
                                    SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 54,
                                      child: ElevatedButton.icon(
                                        onPressed:
                                            _isLoading ? null : _createInvoice,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue.shade700,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          elevation: 4,
                                        ),
                                        icon:
                                            _isLoading
                                                ? SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2,
                                                      ),
                                                )
                                                : Icon(Icons.add),
                                        label: Text(
                                          'Ajouter Facture',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ).animate().fadeIn().slideY(),
                            SizedBox(height: 24),
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
                                  _isLoading
                                      ? Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.blue.shade700,
                                              ),
                                        ),
                                      )
                                      : _filteredInvoices.isEmpty
                                      ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.receipt_long,
                                              size: 80,
                                              color: Colors.blue.shade200,
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              'Aucune facture',
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                color: Colors.blue.shade300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).animate().fadeIn()
                                      : _buildInvoicesList(),
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
              label: 'Rechercher (numéro ou client)',
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
                    _filterInvoices();
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

  Widget _buildInvoicesList() {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: _filteredInvoices.length,
      itemBuilder: (context, index) {
        final invoice = _filteredInvoices[index];
        final date = DateTime.parse(invoice['createdAt']).toLocal();
        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue.shade50,
              child: Icon(Icons.receipt, color: Colors.blue.shade800),
            ),
            title: Text(
              'Facture ${invoice['number']}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice['clientName'],
                  style: GoogleFonts.poppins(color: Colors.grey.shade700),
                ),
                SizedBox(height: 4),
                Text(
                  'Date: ${date.day}/${date.month}/${date.year}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                        invoice['status'] == 'paid'
                            ? Colors.green.shade50
                            : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${invoice['amount']} FCFA - ${invoice['status'] == 'paid' ? 'Payée' : 'Impayée'}',
                    style: GoogleFonts.poppins(
                      color:
                          invoice['status'] == 'paid'
                              ? Colors.green.shade700
                              : Colors.orange.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                invoice['status'] == 'paid' ? Icons.undo : Icons.check_circle,
                color:
                    invoice['status'] == 'paid'
                        ? Colors.red.shade400
                        : Colors.green.shade400,
                size: 30,
              ),
              onPressed:
                  () => _updateInvoiceStatus(invoice['_id'], invoice['status']),
            ),
          ),
        ).animate().fadeIn().slideX();
      },
    );
  }

  @override
  void dispose() {
    _numberController.dispose();
    _clientNameController.dispose();
    _amountController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
