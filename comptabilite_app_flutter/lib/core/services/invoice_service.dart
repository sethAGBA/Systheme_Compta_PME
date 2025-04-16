// filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/features/invoicing/screens/invoice_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'package:ComptaFacile/features/invoicing/screens/invoice_model.dart';
import 'package:ComptaFacile/core/services/api_exceptions.dart';

class InvoiceService {
  Future<Facture> ajouterFacture(Facture facture) async {
    final token = await ApiService.getToken();
    if (token == null) {
      print('Erreur ajouterFacture: Aucun token disponible');
      throw ApiException('Erreur: Aucun token d\'authentification disponible');
    }
    final url = Uri.parse('${ApiService.baseUrl}/invoices');
    print('POST URL: $url');
    print('Token envoyé: $token');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(facture.toJson()),
      );
      print('POST Status: ${response.statusCode}');
      print('POST Response: ${response.body}');
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Facture.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['error'] ?? 'Erreur inconnue';
        throw ApiException('Erreur lors de l\'ajout de la facture: $errorMessage');
      }
    } catch (e) {
      print('Erreur ajouterFacture: $e');
      throw ApiException('Erreur de connexion: $e');
    }
  }

  Future<List<Facture>> chargerFactures() async {
    final token = await ApiService.getToken();
    if (token == null) {
      print('Erreur chargerFactures: Aucun token disponible');
      throw ApiException('Erreur: Aucun token d\'authentification disponible');
    }
    final url = Uri.parse('${ApiService.baseUrl}/invoices');
    print('GET URL: $url');
    print('Token envoyé: $token');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('GET Status: ${response.statusCode}');
      print('GET Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((json) => Facture.fromJson(json)).toList();
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['error'] ?? 'Erreur inconnue';
        throw ApiException('Erreur lors du chargement des factures: $errorMessage');
      }
    } catch (e) {
      print('Erreur chargerFactures: $e');
      throw ApiException('Erreur de connexion: $e');
    }
  }

  Future<void> mettreAJourStatut(String invoiceId, String newStatus) async {
    final token = await ApiService.getToken();
    if (token == null) {
      print('Erreur mettreAJourStatut: Aucun token disponible');
      throw ApiException('Erreur: Aucun token d\'authentification disponible');
    }
    final url = Uri.parse('${ApiService.baseUrl}/invoices/status');
    print('PUT Status URL: $url');
    print('Token envoyé: $token');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'invoiceId': invoiceId, 'status': newStatus}),
      );
      print('PUT Status: ${response.statusCode}');
      print('PUT Status Response: ${response.body}');
      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['error'] ?? 'Erreur inconnue';
        throw ApiException('Erreur lors de la mise à jour du statut: $errorMessage');
      }
    } catch (e) {
      print('Erreur mettreAJourStatut: $e');
      throw ApiException('Erreur de connexion: $e');
    }
  }
Future<void> supprimerFacture(String id) async {
  final token = await ApiService.getToken();
  if (token == null) {
    print('Erreur supprimerFacture: Aucun token disponible');
    throw ApiException('Erreur: Aucun token d\'authentification disponible');
  }
  
  final url = Uri.parse('${ApiService.baseUrl}/invoices/$id');
  print('DELETE URL: $url');
  print('Token envoyé: $token');

  try {
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('DELETE Status: ${response.statusCode}');
    print('DELETE Response: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Facture supprimée avec succès: $id');
    } else {
      final errorData = jsonDecode(response.body);
      final errorMessage = errorData['error'] ?? 'Erreur inconnue';
      throw ApiException('Erreur lors de la suppression de la facture: $errorMessage');
    }
  } catch (e) {
    print('Erreur supprimerFacture: $e');
    if (e is ApiException) {
      rethrow;
    }
    throw ApiException('Erreur de connexion: $e');
  }
}
  Future<Facture> mettreAJourFacture(String id, Facture facture) async {
    final token = await ApiService.getToken();
    if (token == null) {
      print('Erreur mettreAJourFacture: Aucun token disponible');
      throw ApiException('Erreur: Aucun token d\'authentification disponible');
    }
    final url = Uri.parse('${ApiService.baseUrl}/invoices/$id');
    print('PUT URL: $url');
    print('Token envoyé: $token');
    print('Données envoyées: ${jsonEncode(facture.toJson())}');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(facture.toJson()),
      );
      print('PUT Status: ${response.statusCode}');
      print('PUT Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Facture.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['error'] ?? 'Erreur inconnue';
        throw ApiException('Erreur lors de la mise à jour de la facture: $errorMessage');
      }
    } catch (e) {
      print('Erreur mettreAJourFacture: $e');
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Erreur de connexion: $e');
    }
  }

  Future<Facture> convertirDevis(String id) async {
    final token = await ApiService.getToken();
    if (token == null) {
      print('Erreur convertirDevis: Aucun token disponible');
      throw ApiException('Erreur: Aucun token d\'authentification disponible');
    }
    final url = Uri.parse('${ApiService.baseUrl}/invoices/$id/convert');
    print('PATCH URL: $url');
    print('Token envoyé: $token');
    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('PATCH Status: ${response.statusCode}');
      print('PATCH Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Facture.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['error'] ?? 'Erreur inconnue';
        throw ApiException('Erreur lors de la conversion: $errorMessage');
      }
    } catch (e) {
      print('Erreur convertirDevis: $e');
      throw ApiException('Erreur de connexion: $e');
    }
  }
Future<Facture> annulerFacture(String id, String motif, {String? statut}) async {
    final token = await ApiService.getToken();
    if (token == null) {
      print('Erreur annulerFacture: Aucun token disponible');
      throw ApiException('Erreur: Aucun token d\'authentification disponible');
    }
    final url = Uri.parse('${ApiService.baseUrl}/invoices/$id/cancel');
    print('PATCH URL: $url');
    print('Token envoyé: $token');
    final body = {'motif': motif};
    if (statut != null) {
      body['statut'] = statut;
    }
    print('Corps envoyé: ${jsonEncode(body)}');
    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      print('PATCH Status: ${response.statusCode}');
      print('PATCH Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Facture.fromJson(data);
      } else {
        String errorMessage = 'Erreur inconnue';
        if (response.body.contains('<!DOCTYPE html>')) {
          errorMessage = 'Route non trouvée ou serveur mal configuré (statut ${response.statusCode})';
        } else {
          try {
            final errorData = jsonDecode(response.body);
            errorMessage = errorData['error'] ?? 'Erreur inconnue';
          } catch (_) {
            errorMessage = 'Réponse serveur invalide: ${response.body}';
          }
        }
        throw ApiException('Échec de l\'annulation (statut ${response.statusCode}): $errorMessage');
      }
    } catch (e) {
      print('Erreur annulerFacture: $e');
      throw ApiException('Erreur de connexion: $e');
    }
  }
  Future<String> genererPDF(String id) async {
    final token = await ApiService.getToken();
    if (token == null) {
      print('Erreur genererPDF: Aucun token disponible');
      throw ApiException('Erreur: Aucun token d\'authentification disponible');
    }
    final url = Uri.parse('${ApiService.baseUrl}/invoices/$id/pdf');
    print('GET URL: $url');
    print('Token envoyé: $token');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('GET Status: ${response.statusCode}');
      print('GET Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['url'];
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['error'] ?? 'Erreur inconnue';
        throw ApiException('Erreur lors de la génération du PDF: $errorMessage');
      }
    } catch (e) {
      print('Erreur genererPDF: $e');
      throw ApiException('Erreur de connexion: $e');
    }
  }

  Future<void> envoyerParEmail(String id, String email) async {
    final token = await ApiService.getToken();
    if (token == null) {
      print('Erreur envoyerParEmail: Aucun token disponible');
      throw ApiException('Erreur: Aucun token d\'authentification disponible');
    }
    final url = Uri.parse('${ApiService.baseUrl}/invoices/$id/email');
    print('POST URL: $url');
    print('Token envoyé: $token');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'email': email}),
      );
      print('POST Status: ${response.statusCode}');
      print('POST Response: ${response.body}');
      if (response.statusCode == 200) {
        print('Email envoyé pour: $id');
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['error'] ?? 'Erreur inconnue';
        throw ApiException('Erreur lors de l\'envoi de l\'email: $errorMessage');
      }
    } catch (e) {
      print('Erreur envoyerParEmail: $e');
      throw ApiException('Erreur de connexion: $e');
    }
  }
}