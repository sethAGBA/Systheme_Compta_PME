import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/services/api_service.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final _descriptionController = TextEditingController();
  final _montantController = TextEditingController();
  final _entiteDebitController = TextEditingController();
  final _entiteCreditController = TextEditingController();
  final _searchController = TextEditingController();
  String? _typeEntiteDebit = 'Banque';
  String? _typeEntiteCredit = 'Fournisseur';
  List<Map<String, dynamic>> _ecritures = [];
  List<Map<String, dynamic>> _filteredEcritures = [];
  bool _chargement = false;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _chargerEcritures();
    _searchController.addListener(_filterEcritures);
  }

  Future<void> _ajouterEcriture() async {
    if (_descriptionController.text.isEmpty ||
        _montantController.text.isEmpty ||
        _entiteDebitController.text.isEmpty ||
        _entiteCreditController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() => _chargement = true);
    try {
      final token = await ApiService.getToken();
      final reponse = await http.post(
        Uri.parse('${ApiService.baseUrl}/accounting/entries'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'description': _descriptionController.text,
          'debitEntityType': _typeEntiteDebit,
          'debitEntityName': _entiteDebitController.text,
          'creditEntityType': _typeEntiteCredit,
          'creditEntityName': _entiteCreditController.text,
          'amount': double.parse(_montantController.text),
        }),
      );

      if (reponse.statusCode == 201) {
        final newEntry = jsonDecode(reponse.body);
        setState(() {
          _ecritures.add(newEntry);
          _filterEcritures(); // Met à jour la liste filtrée
        });
        _descriptionController.clear();
        _montantController.clear();
        _entiteDebitController.clear();
        _entiteCreditController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Écriture ajoutée avec succès'),
            backgroundColor: Colors.green.shade400,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${reponse.body}'),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur réseau: $e'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() => _chargement = false);
    }
  }

  Future<void> _chargerEcritures() async {
    setState(() => _chargement = true);
    try {
      final token = await ApiService.getToken();
      final reponse = await http.get(
        Uri.parse('${ApiService.baseUrl}/accounting/entries'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('Réponse Chargement Écritures: ${reponse.statusCode} - ${reponse.body}');
      if (reponse.statusCode == 200) {
        setState(() {
          _ecritures = List<Map<String, dynamic>>.from(jsonDecode(reponse.body));
          _filteredEcritures = _ecritures; // Initialise avec toutes les écritures
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${reponse.body}'),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur réseau: $e'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() => _chargement = false);
    }
  }

  void _filterEcritures() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredEcritures = _ecritures.where((ecriture) {
        final ecritureDate = DateTime.parse(ecriture['date']);
        final matchesDate = (_startDate == null || ecritureDate.isAfter(_startDate!)) &&
            (_endDate == null || ecritureDate.isBefore(_endDate!.add(Duration(days: 1))));
        final matchesText = ecriture['description'].toLowerCase().contains(query) ||
            ecriture['debitEntityName'].toLowerCase().contains(query) ||
            ecriture['creditEntityName'].toLowerCase().contains(query);
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
        _filterEcritures();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journal Comptable',
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Formulaire d'ajout
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
                        // Section Débit
                        _buildEntitySection(
                          title: 'Information Débit',
                          typeValue: _typeEntiteDebit,
                          typeOnChanged: (value) => setState(() => _typeEntiteDebit = value),
                          controller: _entiteDebitController,
                          label: 'Entité Débit',
                        ),
                        SizedBox(height: 16),
                        // Section Crédit
                        _buildEntitySection(
                          title: 'Information Crédit',
                          typeValue: _typeEntiteCredit,
                          typeOnChanged: (value) => setState(() => _typeEntiteCredit = value),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _chargement ? null : _ajouterEcriture,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade700,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 4,
                              ),
                              icon: Icon(Icons.add),
                              label: Text(
                                'Ajouter',
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              icon: Icon(Icons.close),
                              label: Text(
                                'Annuler',
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Recherche et filtre
                _buildSearchAndFilter(),
                SizedBox(height: 16),
                // Liste des écritures
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _chargement
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
                            ),
                          )
                        : _filteredEcritures.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: _filteredEcritures.length,
                                itemBuilder: (context, index) {
                                  final ecriture = _filteredEcritures[index];
                                  final date = DateTime.parse(ecriture['date']).toLocal();
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.white, Colors.blue.shade50.withOpacity(0.3)],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.blue.shade100.withOpacity(0.5), width: 0.5),
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
                                        ecriture['description'],
                                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Date: ${date.day}/${date.month}/${date.year}',
                                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade600),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${ecriture['amount']} FCFA',
                                            style: GoogleFonts.poppins(
                                              color: Colors.blue.shade700,
                                              fontWeight: FontWeight.w500,
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
                                                      'Débit: ${ecriture['debitEntityType']} (${ecriture['debitEntityName']})',
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
                                                      'Crédit: ${ecriture['creditEntityType']} (${ecriture['creditEntityName']})',
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
                              ),
                  ),
                ),
              ],
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
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blue.shade800),
          ),
          SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: typeValue,
            items: ['Banque', 'Fournisseur', 'Client', 'Ventes'].map((type) {
              return DropdownMenuItem(value: type, child: Text(type));
            }).toList(),
            onChanged: typeOnChanged,
            decoration: InputDecoration(
              labelText: 'Type',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.blue.shade50,
            ),
          ),
          SizedBox(height: 12),
          _buildTextField(controller: controller, label: label, icon: Icons.business),
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

  @override
  void dispose() {
    _descriptionController.dispose();
    _montantController.dispose();
    _entiteDebitController.dispose();
    _entiteCreditController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}