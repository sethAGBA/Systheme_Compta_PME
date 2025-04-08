// import 'package:comptabilite_app_flutter/features/accounting/screens/journal_screen.dart';
// import 'package:comptabilite_app_flutter/features/invoicing/screens/invoice_screen.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../../../core/services/api_service.dart';
// import '../../auth/screens/login_screen.dart';
// // import '../screens/journal_screen.dart'; // Import pour la navigation
// // ... (imports inchangés)

// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   Map<String, dynamic>? _dashboardData;
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _fetchDashboardData();
//   }

//   Future<void> _fetchDashboardData() async {
//     setState(() => _isLoading = true);
//     try {
//       final token = await ApiService.getToken();
//       final response = await http.get(
//         Uri.parse('${ApiService.baseUrl}/dashboard'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//       print('Dashboard Response: ${response.statusCode} - ${response.body}');
//       if (response.statusCode == 200) {
//         setState(() => _dashboardData = jsonDecode(response.body));
//       } else if (response.statusCode == 401) {
//         await ApiService.logout();
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
//       } else {
//         setState(() => _errorMessage = jsonDecode(response.body)['error'] ?? 'Erreur de chargement');
//       }
//     } catch (e) {
//       print('Erreur réseau dans Dashboard: $e');
//       setState(() => _errorMessage = 'Erreur réseau: $e');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _logout() async {
//     await ApiService.logout();
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
//   }

//   Future<void> _navigateToJournal() async {
//     await Navigator.push(context, MaterialPageRoute(builder: (_) => JournalScreen()));
//     _fetchDashboardData();
//   }

//   Future<void> _navigateToInvoices() async {
//     await Navigator.push(context, MaterialPageRoute(builder: (_) => InvoiceScreen()));
//     _fetchDashboardData(); // Rafraîchit au retour
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tableau de bord', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.blue.shade700,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout, color: Colors.white),
//             onPressed: _logout,
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage != null
//               ? Center(child: Text(_errorMessage!, style: TextStyle(color: Colors.red)))
//               : SingleChildScrollView(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Bienvenue dans ComptaFacile',
//                           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 20),
//                       _buildMetricCard('Chiffre d\'affaires', '${_dashboardData!['revenue'].toStringAsFixed(0)} FCFA'),
//                       _buildMetricCard('Factures impayées', _dashboardData!['unpaidInvoices'].toString()),
//                       _buildMetricCard('Solde total', '${_dashboardData!['totalBalance'].toStringAsFixed(0)} FCFA'),
//                       SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: _navigateToJournal,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue.shade700,
//                           foregroundColor: Colors.white,
//                           minimumSize: Size(double.infinity, 54),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         ),
//                         child: Text('Aller au Journal', style: TextStyle(fontSize: 16)),
//                       ),
//                       SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: _navigateToInvoices,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue.shade700,
//                           foregroundColor: Colors.white,
//                           minimumSize: Size(double.infinity, 54),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         ),
//                         child: Text('Gérer les Factures', style: TextStyle(fontSize: 16)),
//                       ),
//                     ],
//                   ),
//                 ),
//     );
//   }

//   Widget _buildMetricCard(String title, String value) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
//             SizedBox(height: 8),
//             Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue.shade700)),
//           ],
//         ),
//       ),
//     );
//   }
// }