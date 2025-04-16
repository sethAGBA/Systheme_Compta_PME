import 'package:ComptaFacile/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/services/api_service.dart';
// import '../../auth/screens/login_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, String>> _accounts = [];
  List<Map<String, String>> _filteredAccounts = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAccounts();
    _searchController.addListener(_filterAccounts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchAccounts() async {
    setState(() => _isLoading = true);
    try {
      final token = await ApiService.getToken();
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/accounts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _accounts = data.map((item) => {
                'number': item['number'].toString(),
                'label': item['label'].toString(),
              }).toList();
          _filteredAccounts = _accounts;
        });
      } else if (response.statusCode == 401) {
        await ApiService.logout();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      } else {
        setState(() => _errorMessage = 'Erreur lors du chargement des comptes');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Erreur réseau: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _addAccount(String number, String label) async {
    try {
      final token = await ApiService.getToken();
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/accounts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'number': number, 'label': label}),
      );
      if (response.statusCode == 201) {
        setState(() {
          _accounts.add({'number': number, 'label': label});
          _filteredAccounts = _accounts;
        });
      } else {
        setState(() => _errorMessage = jsonDecode(response.body)['error'] ?? 'Erreur lors de l\'ajout');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Erreur réseau: $e');
    }
  }

  Future<void> _editAccount(int index, String number, String label) async {
    try {
      final token = await ApiService.getToken();
      final response = await http.put(
        Uri.parse('${ApiService.baseUrl}/accounts/${_accounts[index]['number']}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'number': number, 'label': label}),
      );
      if (response.statusCode == 200) {
        setState(() {
          _accounts[index] = {'number': number, 'label': label};
          _filteredAccounts = _accounts;
        });
      } else {
        setState(() => _errorMessage = jsonDecode(response.body)['error'] ?? 'Erreur lors de la modification');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Erreur réseau: $e');
    }
  }

  Future<void> _deleteAccount(int index) async {
    try {
      final token = await ApiService.getToken();
      final response = await http.delete(
        Uri.parse('${ApiService.baseUrl}/accounts/${_accounts[index]['number']}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          _accounts.removeAt(index);
          _filteredAccounts = _accounts;
        });
      } else {
        setState(() => _errorMessage = jsonDecode(response.body)['error'] ?? 'Erreur lors de la suppression');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Erreur réseau: $e');
    }
  }

  void _filterAccounts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAccounts = _accounts.where((account) {
        return account['number']!.toLowerCase().contains(query) ||
            account['label']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.white],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              pinned: true,
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
              title: Text(
                'Plan Comptable',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () => _showAddAccountDialog(),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: _buildSearchBar(),
            ),
            if (_isLoading)
              SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
                  ),
                ),
              )
            else if (_errorMessage != null)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 80, color: Colors.red.shade300),
                      SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.red.shade400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchAccounts,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          'Réessayer',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildAccountCard(index),
                    childCount: _filteredAccounts.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Rechercher un compte...',
          hintStyle: GoogleFonts.poppins(color: Colors.grey.shade600),
          prefixIcon: Icon(Icons.search, color: Colors.blue.shade700),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
        style: GoogleFonts.poppins(color: Colors.blue.shade900),
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildAccountCard(int index) {
    final account = _filteredAccounts[index];
    return Card(
      elevation: 6,
      shadowColor: Colors.blue.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          account['label']!,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade900,
          ),
        ),
        subtitle: Text(
          'N° ${account['number']}',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue.shade700),
              onPressed: () => _showEditAccountDialog(index),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red.shade400),
              onPressed: () => _showDeleteConfirmationDialog(index),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.2);
  }

  void _showAddAccountDialog() {
    final numberController = TextEditingController();
    final labelController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Ajouter un compte comptable',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: numberController,
                decoration: InputDecoration(
                  labelText: 'Numéro de compte',
                  labelStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ce champ est requis';
                  }
                  if (_accounts.any((account) => account['number'] == value)) {
                    return 'Ce numéro existe déjà';
                  }
                  return null;
                },
                style: GoogleFonts.poppins(),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: labelController,
                decoration: InputDecoration(
                  labelText: 'Libellé',
                  labelStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ce champ est requis';
                  }
                  return null;
                },
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Annuler',
              style: GoogleFonts.poppins(color: Colors.grey.shade700),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _addAccount(numberController.text, labelController.text);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Sauvegarder',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditAccountDialog(int index) {
    final account = _filteredAccounts[index];
    final numberController = TextEditingController(text: account['number']);
    final labelController = TextEditingController(text: account['label']);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Modifier le compte comptable',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: numberController,
                decoration: InputDecoration(
                  labelText: 'Numéro de compte',
                  labelStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ce champ est requis';
                  }
                  if (value != account['number'] &&
                      _accounts.any((acc) => acc['number'] == value)) {
                    return 'Ce numéro existe déjà';
                  }
                  return null;
                },
                style: GoogleFonts.poppins(),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: labelController,
                decoration: InputDecoration(
                  labelText: 'Libellé',
                  labelStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Ce champ est requis';
                  }
                  return null;
                },
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Annuler',
              style: GoogleFonts.poppins(color: Colors.grey.shade700),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _editAccount(index, numberController.text, labelController.text);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Sauvegarder',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Supprimer le compte',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Voulez-vous vraiment supprimer le compte "${_filteredAccounts[index]['label']}" ?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Annuler',
              style: GoogleFonts.poppins(color: Colors.grey.shade700),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteAccount(index);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Supprimer',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}