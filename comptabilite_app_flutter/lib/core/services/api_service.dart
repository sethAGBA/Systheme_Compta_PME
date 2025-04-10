// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:io' show Platform;

// class ApiService {
//   static const bool isProduction = false; // Changez à true pour la production

//   static String get baseUrl {
//     if (isProduction) {
//       return 'https://afritrade-connect-api.onrender.com';
//     }

//     if (kIsWeb) {
//       return 'http://127.0.0.1:3000'; // Développement sur le web
//     } else if (Platform.isAndroid) {
//       return 'http://10.0.2.2:3000'; // Android Emulator
//     } else if (Platform.isIOS) {
//       return 'http://localhost:3000'; // iOS Simulator
//     } else {
//       return 'http://127.0.0.1:3000'; // Développement sur Desktop
//     }
//   }

//   static Future<Map<String, dynamic>> login(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/auth/login'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email, 'password': password}),
//       );
//       return {
//         'statusCode': response.statusCode,
//         'data': jsonDecode(response.body),
//       };
//     } catch (e) {
//       return {
//         'statusCode': 500,
//         'data': {'message': 'Erreur de connexion: $e'}
//       };
//     }
//   }

//   static Future<Map<String, dynamic>> signup(String email, String password, String role) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/auth/signup'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email, 'password': password, 'role': role}),
//       );
//       return {
//         'statusCode': response.statusCode,
//         'data': jsonDecode(response.body),
//       };
//     } catch (e) {
//       return {
//         'statusCode': 500,
//         'data': {'message': 'Erreur lors de l\'inscription: $e'}
//       };
//     }
//   }

//   static Future<void> saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('jwt_token', token);
//   }

//   static Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('jwt_token');
//   }

//   static Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('jwt_token');
//     await prefs.remove('userId');
//     await prefs.remove('userEmail');
//     await prefs.remove('userRole');
//   }
// }



import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class ApiService {
  static const bool isProduction = false; // Changez à true pour la production

  // Détermine l'URL de base en fonction de l'environnement et de la plateforme
  static String get baseUrl {
    if (isProduction) {
      // return 'https://afritrade-connect-api.onrender.com'; // URL de production
      return 'https://systheme-compta-pme.onrender.com'; // URL de production
     
    }

    if (kIsWeb) {
      return 'http://127.0.0.1:3000'; // Développement sur le web
    } else if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2:3000'; // Émulateur Android
    } else if (!kIsWeb && Platform.isIOS) {
      return 'http://localhost:3000'; // Simulateur iOS
    } else {
      return 'http://127.0.0.1:3000'; // Développement Desktop (Mac/Windows/Linux)
    }
  }

  // Méthode pour login avec logs de débogage
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/login');
      print('Tentative de connexion à: $uri'); // Log de l'URL
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print('Login Response: ${response.statusCode} - ${response.body}'); // Log de la réponse
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      print('Erreur lors de la connexion: $e'); // Log de l'erreur
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur de connexion: $e'},
      };
    }
  }

  // Méthode pour signup avec logs de débogage
  static Future<Map<String, dynamic>> signup(String email, String password, String role) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/signup');
      print('Tentative d\'inscription à: $uri'); // Log de l'URL
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password, 'role': role}),
      );
      print('Signup Response: ${response.statusCode} - ${response.body}'); // Log de la réponse
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      print('Erreur lors de l\'inscription: $e'); // Log de l'erreur
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur lors de l\'inscription: $e'},
      };
    }
  }

  // Sauvegarde du token JWT et des informations utilisateur
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
    print('Token sauvegardé: $token'); // Log pour vérification
  }

  // Récupération du token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    print('Token récupéré: $token'); // Log pour vérification
    return token;
  }

  // Déconnexion avec suppression des données locales
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('userId');
    await prefs.remove('userEmail');
    await prefs.remove('userRole');
    print('Utilisateur déconnecté, données locales supprimées'); // Log pour vérification
  }
}