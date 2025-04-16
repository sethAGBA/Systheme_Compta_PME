// filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/main.dart

import 'package:ComptaFacile/core/models/update.dart';
import 'package:ComptaFacile/features/invoicing/providers/invoice_provider.dart';
import 'package:ComptaFacile/features/invoicing/screens/invoice_screen.dart';
import 'package:ComptaFacile/features/screens/account_screen.dart';
import 'package:ComptaFacile/features/screens/balance_screen.dart';
import 'package:ComptaFacile/features/screens/ledger_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ComptaFacile/core/theme/invoice_theme.dart';
import 'package:ComptaFacile/core/services/api_service.dart';
import 'package:ComptaFacile/features/auth/screens/login_screen.dart';
import 'package:ComptaFacile/features/dashboard/screens/dashboard_screen.dart';
import 'package:ComptaFacile/features/accounting/screens/journal_screen.dart';

var version = '1.0.0+1';
Update update = Update(
  // version: version,
  // changelog: 'Initial release',
  // releaseDate: DateTime.now(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Charger le cache initial
  final provider = InvoiceProvider();
  await provider.fetchInvoices();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => provider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> _checkLoginStatus() async {
    return await ApiService.getToken() != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ComptaFacile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: InvoiceTheme.colors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: InvoiceTheme.colors.primary,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: InvoiceTheme.textStyles.title.copyWith(
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: InvoiceTheme.colors.primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: InvoiceTheme.colors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: InvoiceTheme.colors.error),
          ),
          labelStyle: TextStyle(color: InvoiceTheme.colors.primary),
          errorStyle: TextStyle(color: InvoiceTheme.colors.error),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: InvoiceTheme.colors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: InvoiceTheme.textStyles.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder<bool>(
              future: _checkLoginStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasData && snapshot.data == true) {
                  return  DashboardScreen();
                }
                return  LoginScreen();
              },
            ),
        '/dashboard': (context) =>  DashboardScreen(),
        '/invoices': (context) =>  InvoiceScreen(),
        '/journal': (context) =>  JournalScreen(),
        '/account': (context) =>  AccountScreen(),
        '/ledger': (context) =>  LedgerScreen(),
        '/balance': (context) =>  BalanceScreen(),
      },
    );
  }
}