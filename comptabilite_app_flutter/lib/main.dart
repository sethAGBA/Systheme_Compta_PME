// import 'package:comptabilite_app_flutter/features/auth/screens/dashboard_screen.dart';
// import 'package:comptabilite_app_flutter/features/dashboard/screens/dashboard_screen.dart';
// import 'package:comptabilite_app_flutter/features/dashboard/screens/dashboard_screen.dart';
import 'package:ComptaFacile/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
// import 'package:gestion_comptable_pme/features/dashboard/screens/dashboard_screen.dart';
import 'features/auth/screens/login_screen.dart';
// import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/accounting/screens/journal_screen.dart';
import 'core/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> _checkLoginStatus() async {
    return await ApiService.getToken() != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ComptaFacile',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return snapshot.data == true ? DashboardScreen() : LoginScreen();
        },
      ),
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        '/journal': (context) => JournalScreen(),
      },
    );
  }
}