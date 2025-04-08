// import 'package:comptabilite_app_flutter/features/auth/screens/dashboard_screen.dart';
// import 'package:comptabilite_app_flutter/features/dashboard/screens/dashboard_screen.dart';
// import 'package:comptabilite_app_flutter/features/dashboard/screens/dashboard_screen.dart';
import 'package:ComptaFacile/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
// import 'package:gestion_comptable_pme/features/dashboard/screens/dashboard_screen.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_screen.dart';
import '../../../core/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Veuillez remplir tous les champs');
      return;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      setState(() => _errorMessage = 'Email invalide');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await ApiService.login(email, password);
      if (result['statusCode'] == 200) {
        final data = result['data'];
        final token = data['token'];
        await ApiService.saveToken(token);

        final prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> payload = Jwt.parseJwt(token);
        await prefs.setString('userId', payload['userId']);
        await prefs.setString('userEmail', data['user']['email']);
        await prefs.setString('userRole', payload['role']);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => DashboardScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() => _errorMessage = result['data']['error'] ?? 'Échec de la connexion');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Erreur réseau');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Icon(Icons.account_balance, size: 64, color: Colors.blue.shade700),
                SizedBox(height: 16),
                Text('ComptaFacile', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
                SizedBox(height: 8),
                Text('Connexion à votre espace comptable', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                SizedBox(height: 48),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email, color: Colors.blue),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            prefixIcon: Icon(Icons.lock, color: Colors.blue),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(_errorMessage!, style: TextStyle(color: Colors.red)),
                  ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Se connecter', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen())),
                  child: Text('Créer un compte', style: TextStyle(color: Colors.blue.shade700)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}