// import 'package:comptabilite_app_flutter/features/accounting/screens/journal_screen.dart';
// import 'package:comptabilite_app_flutter/features/invoicing/screens/invoice_screen.dart';
import 'package:ComptaFacile/features/accounting/screens/journal_screen.dart';
import 'package:ComptaFacile/features/invoicing/screens/invoice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:gestion_comptable_pme/features/accounting/screens/journal_screen.dart';
// import 'package:gestion_comptable_pme/features/invoicing/screens/invoice_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../core/services/api_service.dart';
import '../../auth/screens/login_screen.dart';
// import '../screens/journal_screen.dart'; // Import pour la navigation
// ... (imports inchangés)

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? _dashboardData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    setState(() => _isLoading = true);
    try {
      final token = await ApiService.getToken();
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/dashboard'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('Dashboard Response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        setState(() => _dashboardData = jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        await ApiService.logout();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      } else {
        setState(() => _errorMessage = jsonDecode(response.body)['error'] ?? 'Erreur de chargement');
      }
    } catch (e) {
      print('Erreur réseau dans Dashboard: $e');
      setState(() => _errorMessage = 'Erreur réseau: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    await ApiService.logout();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  Future<void> _navigateToJournal() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => JournalScreen()));
    _fetchDashboardData();
  }

  Future<void> _navigateToInvoices() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => InvoiceScreen()));
    _fetchDashboardData(); // Rafraîchit au retour
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
                  ],
                ),
              ),
            )
          else
            ...[
              SliverAppBar(
                floating: false,
                pinned: true,
                stretch: true,
                expandedHeight: 0,
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
                  'Tableau de bord',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.logout, color: Colors.white),
                    onPressed: _logout,
                  ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(
                      'Bienvenue dans ComptaFacile',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ).animate().fadeIn().slideX(),
                    SizedBox(height: 20),
                    _buildMetricsGrid(),
                    SizedBox(height: 20),
                    _buildActionButtons(),
                  ]),
                ),
              ),
            ],
        ],
      ),
      ),
  
  );
}

// Ajoutez cette nouvelle méthode pour la grille de métriques
Widget _buildMetricsGrid() {
  return GridView.count(
    shrinkWrap: true,
    crossAxisCount: 2,
    childAspectRatio: 1.3, // Ajusté pour donner plus d'espace vertical
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    physics: NeverScrollableScrollPhysics(),
    children: [
      _buildMetricCard(
        'CA',  // Raccourci pour Chiffre d'affaires
        NumberFormat.compact().format(_dashboardData!['revenue']) + ' FCFA',
        Icons.monetization_on,
      ),
      _buildMetricCard(
        'Factures',
        _dashboardData!['unpaidInvoices'].toString(),
        Icons.receipt_long,
      ),
      _buildMetricCard(
        'Solde',
        NumberFormat.compact().format(_dashboardData!['totalBalance']) + ' FCFA',
        Icons.account_balance_wallet,
      ),
      _buildMetricCard(
        'Écritures',
        _dashboardData!['totalEntries'].toString(),
        Icons.description,
      ),
    ],
  ).animate().fadeIn();
}
// Modifiez la méthode _buildMetricCard
Widget _buildMetricCard(String title, String value, IconData icon) {
  return Card(
    elevation: 8,
    shadowColor: Colors.blue.withOpacity(0.2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12), // Padding ajusté
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.blue.shade700), // Taille d'icône réduite
          SizedBox(height: 4), // Espacement réduit
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  ).animate().fadeIn().scale();
}
// Ajoutez cette nouvelle méthode pour les boutons d'action
Widget _buildActionButtons() {
  return Column(
    children: [
      _buildActionButton(
        'Journal Comptable',
        Icons.book,
        _navigateToJournal,
      ),
      SizedBox(height: 12),
      _buildActionButton(
        'Gestion des Factures',
        Icons.receipt,
        _navigateToInvoices,
      ),
    ],
  ).animate().fadeIn().slideY();
}

Widget _buildActionButton(String title, IconData icon, VoidCallback onPressed) {
  return Container(
    width: double.infinity,
    height: 60,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}}