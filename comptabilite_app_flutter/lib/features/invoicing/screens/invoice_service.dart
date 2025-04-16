// filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/features/invoicing/screens/invoice_service.dart

import 'dart:convert';
import 'package:ComptaFacile/core/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:ComptaFacile/core/services/api_exceptions.dart';
import 'package:ComptaFacile/features/invoicing/screens/invoice_model.dart';

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

  Future<List<Facture>> chargerFactures({int page = 1, int limit = 10}) async {
    final token = await ApiService.getToken();
    if (token == null) {
      print('Erreur chargerFactures: Aucun token disponible');
      throw ApiException('Erreur: Aucun token d\'authentification disponible');
    }
    final url = Uri.parse('${ApiService.baseUrl}/invoices?page=$page&limit=$limit');
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
        final data = jsonDecode(response.body)['invoices'] as List;
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
    final url = Uri.parse('${ApiService.baseUrl}/invoices/$invoiceId/status');
    print('PUT Status URL: $url');
    print('Token envoyé: $token');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'statut': newStatus}),
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
    final url = Uri.parse('${ApiService.baseUrl}/invoices/$id');
    final token = await ApiService.getToken();
    if (token == null) throw ApiException('Erreur: Aucun token');
    print('DELETE URL: $url');
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
        String errorMessage = 'Erreur inconnue';
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['error'] ?? 'Erreur inconnue';
        } catch (_) {
          errorMessage = 'Réponse serveur invalide: ${response.body}';
        }
        throw ApiException('Erreur lors de la suppression de la facture: $errorMessage');
      }
    } catch (e) {
      print('Erreur supprimerFacture: $e');
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
        final facture = Facture.fromJson(data);
        if (facture.validiteDevis != null && DateTime.now().isAfter(facture.validiteDevis!)) {
          throw ApiException('Erreur: Devis expiré');
        }
        return facture;
      } else {
        String errorMessage = 'Erreur inconnue';
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['error'] ?? 'Erreur inconnue';
        } catch (_) {
          errorMessage = 'Réponse serveur invalide: ${response.body}';
        }
        throw ApiException('Erreur lors de la conversion: $errorMessage');
      }
    } catch (e) {
      print('Erreur convertirDevis: $e');
      throw ApiException('Erreur de connexion: $e');
    }
  }

  Future<Facture> annulerFacture(String id, String motif) async {
    try {
      print('\n=== Début annulation facture ===');
      print('ID: $id');
      print('Motif: $motif');

      if (id.isEmpty) {
        throw ApiException('ID de facture invalide');
      }

      if (motif.isEmpty) {
        throw ApiException('Le motif d\'annulation est requis');
      }

      final token = await ApiService.getToken();
      if (token == null) {
        print('❌ Erreur: Token manquant');
        throw ApiException('Authentification requise');
      }

      final url = Uri.parse('${ApiService.baseUrl}/invoices/$id/cancel');
      print('URL: $url');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
      print('Headers: $headers');

      final body = jsonEncode({'motif': motif});
      print('Corps de la requête: $body');

      final response = await http.patch(
        url,
        headers: headers,
        body: body,
      );

      print('Code de statut: ${response.statusCode}');
      print('Corps de la réponse: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          print('Données reçues: $data');
          final facture = Facture.fromJson(data);
          print('✅ Facture annulée avec succès');
          return facture;
        } catch (e) {
          print('❌ Erreur de parsing JSON: $e');
          throw ApiException(
            'Erreur lors du traitement de la réponse',
            'Format de réponse invalide: ${response.body}',
          );
        }
      } else {
        String errorMessage;
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['error'] ?? 'Erreur inconnue';
        } catch (e) {
          print('❌ Erreur de parsing de l\'erreur: $e');
          errorMessage = 'Erreur ${response.statusCode}: ${response.body}';
        }
        throw ApiException('Échec de l\'annulation', errorMessage);
      }
    } catch (e) {
      print('\n❌ ERREUR ANNULATION FACTURE');
      print('Type: ${e.runtimeType}');
      print('Message: $e');

      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
        'Erreur lors de l\'annulation',
        'Une erreur inattendue est survenue: $e',
      );
    }
  }

  Future<Facture> createFinalInvoice(String acompteInvoiceId, Facture facture) async {
    final token = await ApiService.getToken();
    if (token == null) throw ApiException('Erreur: Aucun token');
    final url = Uri.parse('${ApiService.baseUrl}/invoices/final');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'acompteInvoiceId': acompteInvoiceId,
          ...facture.toJson(),
        }),
      );
      if (response.statusCode == 201) {
        return Facture.fromJson(jsonDecode(response.body));
      }
      throw ApiException('Erreur lors de la création de la facture finale: ${response.body}');
    } catch (e) {
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
        String errorMessage = 'Erreur inconnue';
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['error'] ?? 'Erreur inconnue';
        } catch (_) {
          errorMessage = 'Réponse serveur invalide: ${response.body}';
        }
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
        String errorMessage = 'Erreur inconnue';
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['error'] ?? 'Erreur inconnue';
        } catch (_) {
          errorMessage = 'Réponse serveur invalide: ${response.body}';
        }
        throw ApiException('Erreur lors de l\'envoi de l\'email: $errorMessage');
      }
    } catch (e) {
      print('Erreur envoyerParEmail: $e');
      throw ApiException('Erreur de connexion: $e');
    }
  }
}