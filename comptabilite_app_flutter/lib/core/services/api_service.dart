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

// // //fichier api_service.dart
// // // ce fichier est responsable de la gestion des opérations liées à l'API
// // // il contient des méthodes pour la connexion, l'inscription, la sauvegarde et la récupération du token
// // // il utilise le package http pour effectuer des requêtes HTTP
// // // il utilise le package json pour encoder et décoder les données JSON

// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'dart:io' show Platform;

// class ApiService {
//   static const bool isProduction = false; // Changez à true pour la production

//   // Détermine l'URL de base en fonction de l'environnement et de la plateforme
//   static String get baseUrl {
//     if (isProduction) {
//       // return 'https://afritrade-connect-api.onrender.com'; // URL de production
//       return 'https://systheme-compta-pme.onrender.com'; // URL de production
     
//     }

//     if (kIsWeb) {
//       return 'http://127.0.0.1:3000'; // Développement sur le web
//     } else if (!kIsWeb && Platform.isAndroid) {
//       return 'http://10.0.2.2:3000'; // Émulateur Android
//     } else if (!kIsWeb && Platform.isIOS) {
//       return 'http://localhost:3000'; // Simulateur iOS
//     } else {
//       return 'http://127.0.0.1:3000'; // Développement Desktop (Mac/Windows/Linux)
//     }
//   }

//   // Méthode pour login avec logs de débogage
//   static Future<Map<String, dynamic>> login(String email, String password) async {
//     try {
//       final uri = Uri.parse('$baseUrl/auth/login');
//       // print('Tentative de connexion à: $uri'); // Log de l'URL
//       final response = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email, 'password': password}),
//       );
//       // print('Login Response: ${response.statusCode} - ${response.body}'); // Log de la réponse
//       return {
//         'statusCode': response.statusCode,
//         'data': jsonDecode(response.body),
//       };
//     } catch (e) {
//       // print('Erreur lors de la connexion: $e'); // Log de l'erreur
//       return {
//         'statusCode': 500,
//         'data': {'error': 'Erreur de connexion: $e'},
//       };
//     }
//   }

//   // Méthode pour signup avec logs de débogage
//   static Future<Map<String, dynamic>> signup(String email, String password, String role) async {
//     try {
//       final uri = Uri.parse('$baseUrl/auth/signup');
//       // print('Tentative d\'inscription à: $uri'); // Log de l'URL
//       final response = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email, 'password': password, 'role': role}),
//       );
//       // print('Signup Response: ${response.statusCode} - ${response.body}'); // Log de la réponse
//       return {
//         'statusCode': response.statusCode,
//         'data': jsonDecode(response.body),
//       };
//     } catch (e) {
//       print('Erreur lors de l\'inscription: $e'); // Log de l'erreur
//       return {
//         'statusCode': 500,
//         'data': {'error': 'Erreur lors de l\'inscription: $e'},
//       };
//     }
//   }

//   // Sauvegarde du token JWT et des informations utilisateur
//   static Future<void> saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('jwt_token', token);
//     // print('Token sauvegardé: $token'); // Log pour vérification
//   }

//   // Récupération du token
//   static Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('jwt_token');
//     // print('Token récupéré: $token'); // Log pour vérification
//     return token;
//   }

//   // Déconnexion avec suppression des données locales
//   static Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('jwt_token');
//     await prefs.remove('userId');
//     await prefs.remove('userEmail');
//     await prefs.remove('userRole');
//     print('Utilisateur déconnecté, données locales supprimées'); // Log pour vérification
//   }
// }



// filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/services/api_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform, File, Directory; // Ajout de Directory
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ApiService {
  static const bool isProduction = false;

  static String get baseUrl {
    if (isProduction) {
      return 'https://systheme-compta-pme.onrender.com';
    }
    if (kIsWeb) return 'http://127.0.0.1:3000';
    if (!kIsWeb && Platform.isAndroid) return 'http://10.0.2.2:3000';
    if (!kIsWeb && Platform.isIOS) return 'http://localhost:3000';
    return 'http://127.0.0.1:3000';
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/login');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur de connexion: $e'},
      };
    }
  }

  static Future<Map<String, dynamic>> signup(String email, String password, String role) async {
    try {
      final uri = Uri.parse('$baseUrl/auth/signup');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password, 'role': role}),
      );
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur lors de l\'inscription: $e'},
      };
    }
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('userId');
    await prefs.remove('userEmail');
    await prefs.remove('userRole');
  }

  static Future<Map<String, dynamic>> createInvoice(Map<String, dynamic> invoiceData) async {
    final token = await getToken();
    try {
      final uri = Uri.parse('$baseUrl/invoices');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(invoiceData),
      );
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur réseau: $e'},
      };
    }
  }

  static Future<Map<String, dynamic>> getInvoices({int page = 1, int limit = 10, String? type, String? statut, String? search}) async {
    final token = await getToken();
    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        if (type != null) 'type': type,
        if (statut != null) 'statut': statut,
        if (search != null) 'search': search,
      };
      final uri = Uri.parse('$baseUrl/invoices').replace(queryParameters: queryParams);
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur réseau: $e'},
      };
    }
  }

  static Future<Map<String, dynamic>> getInvoice(String id) async {
    final token = await getToken();
    try {
      final uri = Uri.parse('$baseUrl/invoices/$id');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur réseau: $e'},
      };
    }
  }

  static Future<Map<String, dynamic>> updateInvoice(String id, Map<String, dynamic> invoiceData) async {
    final token = await getToken();
    try {
      final uri = Uri.parse('$baseUrl/invoices/$id');
      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(invoiceData),
      );
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur réseau: $e'},
      };
    }
  }

  static Future<Map<String, dynamic>> deleteInvoice(String id) async {
    final token = await getToken();
    try {
      final uri = Uri.parse('$baseUrl/invoices/$id');
      final response = await http.delete(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur réseau: $e'},
      };
    }
  }

  static Future<Map<String, dynamic>> cancelInvoice(String id, String motif) async {
    final token = await getToken();
    try {
      final uri = Uri.parse('$baseUrl/invoices/$id/cancel');
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'motifAnnulation': motif}),
      );
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur réseau: $e'},
      };
    }
  }

  static Future<Map<String, dynamic>> convertDevis(String id) async {
    final token = await getToken();
    try {
      final uri = Uri.parse('$baseUrl/invoices/$id/convert');
      final response = await http.put(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur réseau: $e'},
      };
    }
  }

  static Future<Map<String, dynamic>> generateInvoicePdf(String id) async {
    final token = await getToken();
    try {
      final uri = Uri.parse('$baseUrl/invoices/$id/pdf');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur réseau: $e'},
      };
    }
  }

  static Future<String?> downloadAndSavePdf(String pdfUrl, String invoiceNumber) async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse('$baseUrl$pdfUrl'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw Exception('Erreur lors du téléchargement du PDF: ${response.statusCode}');
      }

      // Demander la permission de stockage
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        var status = await Permission.storage.request();
        print('Permission status: $status');
        if (!status.isGranted) {
          throw Exception('Permission de stockage refusée');
        }
      }

      // Obtenir le dossier de sauvegarde
      String directory;
      if (kIsWeb) {
        // Web : non supporté pour sauvegarde locale
        throw Exception('Sauvegarde locale non supportée sur le web');
      } else if (Platform.isAndroid) {
        // Essayer DCIM ou un dossier personnalisé
        directory = '/storage/emulated/0/DCIM';
        final externalDirs = await getExternalStorageDirectories();
        if (externalDirs != null && externalDirs.isNotEmpty) {
          directory = externalDirs[0].path;
        }
      } else {
        directory = (await getApplicationDocumentsDirectory()).path;
      }

      // Créer le dossier si nécessaire
      final dir = Directory(directory);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
        print('Dossier créé: $directory');
      }

      // Sauvegarder le fichier
      final filename = 'facture-$invoiceNumber.pdf';
      final file = File('$directory/$filename');
      await file.writeAsBytes(response.bodyBytes);
      print('PDF sauvegardé: ${file.path}');

      return file.path;
    } catch (e) {
      print('Erreur downloadAndSavePdf: $e');
      return null;
    }
  }
static Future<Map<String, dynamic>> updateInvoiceStatus(String id, String status) async {
    try {
      // Remplacez par votre endpoint réel, ex. : PATCH /invoices/:id/status
      final response = await http.patch(
        Uri.parse('https://api.example.com/invoices/$id/status'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'statut': status}),
      );
      final data = jsonDecode(response.body);
      return {
        'statusCode': response.statusCode,
        'data': data,
      };
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }
  static Future<Map<String, dynamic>> generateFEC() async {
    final token = await getToken();
    try {
      final uri = Uri.parse('$baseUrl/invoices/fec');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      return {
        'statusCode': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } catch (e) {
      return {
        'statusCode': 500,
        'data': {'error': 'Erreur réseau: $e'},
      };
    }
  }
}