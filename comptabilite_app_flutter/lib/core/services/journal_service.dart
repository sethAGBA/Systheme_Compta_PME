import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class JournalService {
  Future<void> ajouterEcriture(Map<String, dynamic> ecriture) async {
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
}