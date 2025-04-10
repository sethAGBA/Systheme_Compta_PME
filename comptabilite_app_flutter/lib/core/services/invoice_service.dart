import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class InvoiceService {
  Future<void> ajouterFacture(Map<String, dynamic> facture) async {
    final token = await ApiService.getToken();
    final url = Uri.parse('${ApiService.baseUrl}/invoices');
    print('POST URL: $url');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(facture),
    );
    // print('POST Status: ${response.statusCode}');
    // print('POST Response: ${response.body}');
    if (response.statusCode != 201) {
      throw Exception('Erreur lors de l\'ajout de la facture : ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> chargerFactures() async {
    final token = await ApiService.getToken();
    final url = Uri.parse('${ApiService.baseUrl}/invoices');
    print('GET URL: $url');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    // print('GET Status: ${response.statusCode}');
    // print('GET Response: ${response.body}');
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Erreur lors du chargement des factures : ${response.body}');
    }
  }

  Future<void> mettreAJourStatut(String invoiceId, String newStatus) async {
    final token = await ApiService.getToken();
    final url = Uri.parse('${ApiService.baseUrl}/invoices/status');
    // print('PUT Status URL: $url');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'invoiceId': invoiceId, 'status': newStatus}),
    );
    // print('PUT Status: ${response.statusCode}');
    // print('PUT Status Response: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la mise à jour du statut : ${response.body}');
    }
  }

  Future<void> supprimerFacture(String id) async {
    final token = await ApiService.getToken();
    final url = Uri.parse('${ApiService.baseUrl}/invoices/$id');
    // print('DELETE URL: $url');
    // print('Token envoyé: $token');
    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    // print('DELETE Status: ${response.statusCode}');
    // print('DELETE Response: ${response.body}');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erreur lors de la suppression de la facture : ${response.body}');
    }
  }

  Future<void> mettreAJourFacture(String id, Map<String, dynamic> data) async {
    final token = await ApiService.getToken();
    final url = Uri.parse('${ApiService.baseUrl}/invoices/$id');
    // print('PUT URL: $url');
    // print('Token envoyé: $token');
    // print('Données envoyées: ${jsonEncode(data)}');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    // print('PUT Status: ${response.statusCode}');
    // print('PUT Response: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la mise à jour de la facture : ${response.body}');
    }
  }
}