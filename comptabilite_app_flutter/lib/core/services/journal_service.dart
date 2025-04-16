// ce fichier est responsable de la gestion des opérations liées au journal comptable
// il contient des méthodes pour ajouter, charger, supprimer et mettre à jour les écritures comptables
// il utilise l'API pour effectuer ces opérations
// il utilise le package http pour effectuer des requêtes HTTP
// il utilise le package json pour encoder et décoder les données JSON
// il utilise le service ApiService pour obtenir le token d'authentification
// il utilise le package http pour effectuer des requêtes HTTP
// il utilise le package json pour encoder et décoder les données JSON
// il utilise le service ApiService pour obtenir le token d'authentification
// il utilise le package http pour effectuer des requêtes HTTP
// il utilise le package json pour encoder et décoder les données JSON
// il s'appel JournalService.dart
// JournalService.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class JournalService {
  Future<Map<String, dynamic>> ajouterEcriture(Map<String, dynamic> ecriture) async {
    final token = await ApiService.getToken();
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/accounting/entries'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(ecriture),
    );
    if (response.statusCode != 201) {
      throw Exception('Erreur: ${response.body}');
    }
    return jsonDecode(response.body); // Retourner l'entrée créée
  }
Future<void> ajouterFacture(Map<String, dynamic> facture) async {
    final token = await ApiService.getToken();
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/invoices'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode(facture),
    );
    if (response.statusCode != 201) throw Exception('Erreur: ${response.body}');
  }

  Future<void> convertirDevis(String id) async {
    final token = await ApiService.getToken();
    final response = await http.put(
      Uri.parse('${ApiService.baseUrl}/invoices/$id/convert'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) throw Exception('Erreur: ${response.body}');
  }

  Future<void> annulerFacture(String id, String motif) async {
    final token = await ApiService.getToken();
    final response = await http.put(
      Uri.parse('${ApiService.baseUrl}/invoices/$id/cancel'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode({'motifAnnulation': motif}),
    );
    if (response.statusCode != 200) throw Exception('Erreur: ${response.body}');
  }
  Future<List<Map<String, dynamic>>> chargerEcritures() async {
    final token = await ApiService.getToken();
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/accounting/entries'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Erreur: ${response.body}');
    }
  }

  Future<void> supprimerEcriture(String id) async {
    final token = await ApiService.getToken();
    final response = await http.delete(
      Uri.parse('${ApiService.baseUrl}/accounting/entries/$id'), // Correction du chemin
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      throw Exception('Erreur: ${response.body}');
    }
  }

  Future<void> mettreAJourEcriture(String id, Map<String, dynamic> data) async {
    final token = await ApiService.getToken();
    final response = await http.put(
      Uri.parse('${ApiService.baseUrl}/accounting/entries/$id'), // Correction du chemin
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Erreur: ${response.body}');
    }
  }
}