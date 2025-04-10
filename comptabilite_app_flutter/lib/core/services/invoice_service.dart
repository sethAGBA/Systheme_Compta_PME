//ce fichier contient des méthodes pour se connecter, s'inscrire, se déconnecter et obtenir le token d'authentification
// il utilise le package http pour effectuer des requêtes HTTP
// il utilise le package json pour encoder et décoder les données JSON
//il s'appelle api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class InvoiceService {
  Future<void> ajouterFacture(Map<String, dynamic> facture) async {
    final token = await ApiService.getToken();
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/invoices'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(facture),
    );
    if (response.statusCode != 201) {
      throw Exception('Erreur: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> chargerFactures() async {
    final token = await ApiService.getToken();
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/invoices'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Erreur: ${response.body}');
    }
  }

  Future<void> mettreAJourStatut(String invoiceId, String newStatus) async {
    final token = await ApiService.getToken();
    final response = await http.put(
      Uri.parse('${ApiService.baseUrl}/invoices/status'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'invoiceId': invoiceId, 'status': newStatus}),
    );
    if (response.statusCode != 200) {
      throw Exception('Erreur: ${response.body}');
    }
  }

Future<void> supprimerFacture(String id) async {
  await http.delete(Uri.parse('${ApiService.baseUrl}/invoices/$id')); // Adapte selon ton API
}

Future<void> mettreAJourFacture(String id, Map<String, dynamic> data) async {
  await http.put(Uri.parse('${ApiService.baseUrl}/invoices/$id'), body: json.encode(data), headers: {'Content-Type': 'application/json'});
}
}