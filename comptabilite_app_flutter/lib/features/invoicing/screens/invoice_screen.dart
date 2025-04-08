import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/services/api_service.dart';
import 'package:intl/intl.dart'; // Pour formater les dates en français

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

  @override
  void initState() {
    super.initState();
    _fetchInvoices();
    _searchController.addListener(_filterInvoices);
  }

  Future<void> _fetchInvoices() async {
    setState(() => _isLoading = true);
    try {
      final token = await ApiService.getToken();
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/invoices'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('Invoices Response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        setState(() {
          _invoices = List<Map<String, dynamic>>.from(jsonDecode(response.body));
          _filteredInvoices = _invoices;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: ${response.body}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur réseau: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createInvoice() async {
    if (_numberController.text.isEmpty || _clientNameController.text.isEmpty || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez remplir tous les champs')));
      return;
    }
    setState(() => _isLoading = true);
    try {
      final token = await ApiService.getToken();
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/invoices'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'number': _numberController.text,
          'clientName': _clientNameController.text,
          'amount': double.parse(_amountController.text),
        }),
      );
      print('Create Invoice Response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 201) {
        final newInvoice = jsonDecode(response.body);
        setState(() {
          _invoices.add(newInvoice);
          _filterInvoices();
        });
        _numberController.clear();
        _clientNameController.clear();
        _amountController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: ${response.body}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur réseau: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateInvoiceStatus(String invoiceId, String currentStatus) async {
    final newStatus = currentStatus == 'paid' ? 'unpaid' : 'paid';
    setState(() => _isLoading = true);
    try {
      final token = await ApiService.getToken();
      final response = await http.put(
        Uri.parse('${ApiService.baseUrl}/invoices/status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'invoiceId': invoiceId, 'status': newStatus}),
      );
      print('Update Invoice Response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final updatedInvoice = jsonDecode(response.body);
        setState(() {
          final index = _invoices.indexWhere((inv) => inv['_id'] == invoiceId);
          if (index != -1) {
            _invoices[index] = updatedInvoice;
            _filterInvoices();
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: ${response.body}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur réseau: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _filterInvoices() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredInvoices = _invoices.where((invoice) {
        final invoiceDate = DateTime.parse(invoice['createdAt']);
        final matchesDate = (_startDate == null || invoiceDate.isAfter(_startDate!)) &&
            (_endDate == null || invoiceDate.isBefore(_endDate!.add(Duration(days: 1))));
        final matchesText = invoice['number'].toLowerCase().contains(query) ||
            invoice['clientName'].toLowerCase().contains(query);
        return matchesDate && (query.isEmpty || matchesText);
      }).toList();
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      locale: const Locale('fr', 'FR'), // Calendrier en français
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue.shade700,
            colorScheme: ColorScheme.light(primary: Colors.blue.shade700),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _filterInvoices();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gestion des Factures',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
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
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                elevation: 8,
                shadowColor: Colors.blue.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      ElevatedButton(
                        onPressed: _isLoading ? null : _createInvoice,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          minimumSize: Size(double.infinity, 54),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                        ),
                        child: _isLoading
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : Text(
                                'Ajouter Facture',
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              _buildSearchAndFilter(),
              SizedBox(height: 16),
              Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700)))
                    : _filteredInvoices.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.receipt_long, size: 80, color: Colors.blue.shade200),
                                SizedBox(height: 16),
                                Text(
                                  'Aucune facture trouvée',
                                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.blue.shade300),
                                ),
                              ],
                            ),
                          ).animate().fadeIn()
                        : _buildInvoicesList(),
              ),
            ],
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
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher (numéro ou client)',
                labelStyle: GoogleFonts.poppins(),
                prefixIcon: Icon(Icons.search, color: Colors.blue.shade700),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _startDate != null && _endDate != null
                        ? 'Du ${_startDate!.day}/${_startDate!.month}/${_startDate!.year} au ${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                        : 'Filtrer par période',
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.blue.shade700),
                  onPressed: () => _selectDateRange(context),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn();
  }

  Widget _buildInvoicesList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.blue.shade100.withOpacity(0.2), blurRadius: 10, spreadRadius: 2)],
      ),
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: _filteredInvoices.length,
        itemBuilder: (context, index) {
          final invoice = _filteredInvoices[index];
          final date = DateTime.parse(invoice['createdAt']).toLocal();
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue.shade50,
                child: Icon(Icons.receipt, color: Colors.blue.shade800),
              ),
              title: Text(
                'Facture ${invoice['number']}',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(invoice['clientName'], style: GoogleFonts.poppins(color: Colors.grey.shade700)),
                  SizedBox(height: 4),
                  Text(
                    'Date: ${date.day}/${date.month}/${date.year}',
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: invoice['status'] == 'paid' ? Colors.green.shade50 : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${invoice['amount']} FCFA - ${invoice['status'] == 'paid' ? 'Payée' : 'Impayée'}',
                      style: GoogleFonts.poppins(
                        color: invoice['status'] == 'paid' ? Colors.green.shade700 : Colors.orange.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  invoice['status'] == 'paid' ? Icons.undo : Icons.check_circle,
                  color: invoice['status'] == 'paid' ? Colors.red.shade400 : Colors.green.shade400,
                  size: 30,
                ),
                onPressed: () => _updateInvoiceStatus(invoice['_id'], invoice['status']),
              ),
            ),
          ).animate().fadeIn().slideX();
        },
      ),
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