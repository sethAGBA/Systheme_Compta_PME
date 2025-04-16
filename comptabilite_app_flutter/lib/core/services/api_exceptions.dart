// filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/core/services/api_exceptions.dart

class ApiException implements Exception {
  final String message;
  final dynamic details;

  ApiException(this.message, [this.details]);

  @override
  String toString() {
    print('=== Détails de l\'erreur API ===');
    print('Message: $message');
    print('Détails: ${details ?? "Aucun détail"}');
    print('============================');

    String displayMessage = message;
    if (details != null) {
      if (details.contains('SIRET')) {
        displayMessage = 'SIRET manquant ou invalide';
      } else if (details.contains('penalites')) {
        displayMessage = 'Pénalités de retard requises';
      }
    }
    return 'ApiException: $displayMessage${details != null ? ' ($details)' : ''}';
  }
}