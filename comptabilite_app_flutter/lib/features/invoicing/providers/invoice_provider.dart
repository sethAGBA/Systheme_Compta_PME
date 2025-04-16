// // filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/features/invoicing/providers/invoice_provider.dart

// import 'dart:convert';
// import 'package:ComptaFacile/core/services/api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:ComptaFacile/features/invoicing/screens/invoice_model.dart';
// // import 'package:ComptaFacile/services/api_service.dart';

// class InvoiceProvider with ChangeNotifier {
//   List<Facture> _invoices = [];
//   bool _isLoading = false;
//   String? _error;
//   String _filter = 'Toutes';

//   List<Facture> get invoices => _invoices;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   String get filter => _filter;

//   Future<void> fetchInvoices({String? type, String? statut, String? search}) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       final response = await ApiService.getInvoices(type: type, statut: statut, search: search);
//       if (response['statusCode'] == 200) {
//         final data = response['data']['invoices'] as List;
//         _invoices = data.map((json) => Facture.fromJson(json)).toList();
//       } else {
//         _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
//       }
//     } catch (e) {
//       _error = 'Erreur réseau: $e';
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> addInvoice(Facture facture) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       final response = await ApiService.createInvoice(facture.toJson());
//       if (response['statusCode'] == 201) {
//         final data = response['data'];
//         _invoices.add(Facture.fromJson(data));
//       } else {
//         _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
//       }
//     } catch (e) {
//       _error = 'Erreur réseau: $e';
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> updateInvoice(String id, Facture facture) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       final response = await ApiService.updateInvoice(id, facture.toJson());
//       if (response['statusCode'] == 200) {
//         final index = _invoices.indexWhere((f) => f.id == id);
//         if (index != -1) {
//           _invoices[index] = Facture.fromJson(response['data']);
//         }
//       } else {
//         _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
//       }
//     } catch (e) {
//       _error = 'Erreur réseau: $e';
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> deleteInvoice(String id) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       final response = await ApiService.deleteInvoice(id);
//       if (response['statusCode'] == 200) {
//         _invoices.removeWhere((f) => f.id == id);
//       } else {
//         _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
//       }
//     } catch (e) {
//       _error = 'Erreur réseau: $e';
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> cancelInvoice(String id, String motif) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       final response = await ApiService.cancelInvoice(id, motif);
//       if (response['statusCode'] == 200) {
//         final index = _invoices.indexWhere((f) => f.id == id);
//         if (index != -1) {
//           _invoices[index] = Facture.fromJson(response['data']);
//         }
//       } else {
//         _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
//       }
//     } catch (e) {
//       _error = 'Erreur réseau: $e';
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> convertDevis(String id) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       final response = await ApiService.convertDevis(id);
//       if (response['statusCode'] == 200) {
//         final index = _invoices.indexWhere((f) => f.id == id);
//         if (index != -1) {
//           _invoices[index] = Facture.fromJson(response['data']);
//         }
//       } else {
//         _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
//       }
//     } catch (e) {
//       _error = 'Erreur réseau: $e';
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<String?> generatePdf(String id) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       final response = await ApiService.generateInvoicePdf(id);
//       if (response['statusCode'] == 200) {
//         return response['data']['url'];
//       } else {
//         _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
//       }
//     } catch (e) {
//       _error = 'Erreur réseau: $e';
//     }
//     _isLoading = false;
//     notifyListeners();
//     return null;
//   }

//   Future<String?> generateFEC() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//     try {
//       final response = await ApiService.generateFEC();
//       if (response['statusCode'] == 200) {
//         return response['data']['url'];
//       } else {
//         _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
//       }
//     } catch (e) {
//       _error = 'Erreur réseau: $e';
//     }
//     _isLoading = false;
//     notifyListeners();
//     return null;
//   }

//   void setFilter(String value) {
//     _filter = value;
//     notifyListeners();
//   }
// }


// filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/features/invoicing/providers/invoice_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ComptaFacile/core/services/api_service.dart';
import 'package:ComptaFacile/features/invoicing/screens/invoice_model.dart';

class InvoiceProvider with ChangeNotifier {
  List<Facture> _invoices = [];
  bool _isLoading = false;
  String? _error;
  String _filter = 'Toutes';

  List<Facture> get invoices => _invoices;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get filter => _filter;

  Future<void> fetchInvoices({String? type, String? statut, String? search}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await ApiService.getInvoices(type: type, statut: statut, search: search);
      if (response['statusCode'] == 200) {
        final data = response['data']['invoices'] as List;
        _invoices = data.map((json) => Facture.fromJson(json)).toList();
      } else {
        _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
      }
    } catch (e) {
      _error = 'Erreur réseau: $e';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addInvoice(Facture facture) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await ApiService.createInvoice(facture.toJson());
      if (response['statusCode'] == 201) {
        final data = response['data'];
        _invoices.add(Facture.fromJson(data));
      } else {
        _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
      }
    } catch (e) {
      _error = 'Erreur réseau: $e';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateInvoice(String id, Facture facture) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await ApiService.updateInvoice(id, facture.toJson());
      if (response['statusCode'] == 200) {
        final index = _invoices.indexWhere((f) => f.id == id);
        if (index != -1) {
          _invoices[index] = Facture.fromJson(response['data']);
        }
      } else {
        _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
      }
    } catch (e) {
      _error = 'Erreur réseau: $e';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteInvoice(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await ApiService.deleteInvoice(id);
      if (response['statusCode'] == 200) {
        _invoices.removeWhere((f) => f.id == id);
      } else {
        _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
      }
    } catch (e) {
      _error = 'Erreur réseau: $e';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> cancelInvoice(String id, String motif) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await ApiService.cancelInvoice(id, motif);
      if (response['statusCode'] == 200) {
        final index = _invoices.indexWhere((f) => f.id == id);
        if (index != -1) {
          _invoices[index] = Facture.fromJson(response['data']);
        }
      } else {
        _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
      }
    } catch (e) {
      _error = 'Erreur réseau: $e';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> convertDevis(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await ApiService.convertDevis(id);
      if (response['statusCode'] == 200) {
        final index = _invoices.indexWhere((f) => f.id == id);
        if (index != -1) {
          _invoices[index] = Facture.fromJson(response['data']);
        }
      } else {
        _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
      }
    } catch (e) {
      _error = 'Erreur réseau: $e';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<String?> generatePdf(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await ApiService.generateInvoicePdf(id);
      if (response['statusCode'] == 200) {
        final pdfUrl = response['data']['url'];
        final invoice = _invoices.firstWhere(
          (f) => f.id == id,
          orElse: () => Facture(
            numero: 'unknown',
            type: FactureType.standard,
            statut: StatutFacture.brouillon,
            dateEmission: DateTime.now(),
            dateEcheance: DateTime.now().add(Duration(days: 30)),
            clientNom: 'Inconnu',
            lignes: [],
          ),
        );
        final filePath = await ApiService.downloadAndSavePdf(pdfUrl, invoice.numero);
        if (filePath == null) {
          _error = 'Erreur lors de la sauvegarde du PDF';
        }
        return filePath;
      } else {
        _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
      }
    } catch (e) {
      _error = 'Erreur réseau: $e';
    }
    _isLoading = false;
    notifyListeners();
    return null;
  }

  Future<String?> generateFEC() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await ApiService.generateFEC();
      if (response['statusCode'] == 200) {
        return response['data']['url'];
      } else {
        _error = response['data']['error'] ?? 'Erreur ${response['statusCode']}';
      }
    } catch (e) {
      _error = 'Erreur réseau: $e';
    }
    _isLoading = false;
    notifyListeners();
    return null;
  }

  void setFilter(String value) {
    _filter = value;
    notifyListeners();
  }
}

