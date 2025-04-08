// import 'package:comptabilite_app_flutter/features/auth/screens/dashboard_screen.dart';
// import 'package:comptabilite_app_flutter/features/dashboard/screens/dashboard_screen.dart';
import 'package:ComptaFacile/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
// import 'package:gestion_comptable_pme/features/dashboard/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/services/api_service.dart';
import 'login_screen.dart';
// import '../../dashboard/screens/dashboard_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'user';
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _signup() async {
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
    if (password.length < 6) {
      setState(() => _errorMessage = 'Mot de passe trop court (min. 6 caractères)');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final response = await ApiService.signup(email, password, _selectedRole);
      if (response['statusCode'] == 201) {
        final data = response['data'];
        await ApiService.saveToken(data['token']);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', data['user']['id']);
        await prefs.setString('userEmail', data['user']['email']);
        await prefs.setString('userRole', data['user']['role']);
        
       Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => DashboardScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() => _errorMessage = response['data']['error'] ?? 'Échec de l\'inscription');
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
                Text('Créez votre compte comptable', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
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
                        SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _selectedRole,
                          decoration: InputDecoration(
                            labelText: 'Rôle',
                            prefixIcon: Icon(Icons.person, color: Colors.blue),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          items: ['user', 'admin']
                              .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                              .toList(),
                          onChanged: (value) => setState(() => _selectedRole = value!),
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
                  onPressed: _isLoading ? null : _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('S\'inscrire', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())),
                  child: Text('Déjà un compte ? Se connecter', style: TextStyle(color: Colors.blue.shade700)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}