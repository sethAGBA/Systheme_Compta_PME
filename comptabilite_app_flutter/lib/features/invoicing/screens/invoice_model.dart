// // filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/features/invoicing/screens/invoice_model.dart

import 'package:html/parser.dart' show parse;

enum FactureType {
  standard,
  recurrente,
  acompte,
  avoir,
  devis,
}

enum StatutFacture {
  brouillon,
  envoyee,
  payee,
  enRetard,
  annulee,
  enAttente,
  accepte,
  refuse,
}

class InvoiceLine {
  String? id;
  String description;
  int quantite;
  double prixUnitaire;
  double remise;
  double rabais;
  double ristourne;
  double tva;

  InvoiceLine({
    this.id,
    required this.description,
    required this.quantite,
    required this.prixUnitaire,
    this.remise = 0.0,
    this.rabais = 0.0,
    this.ristourne = 0.0,
    this.tva = 0.0,
  });

  double get montantHT {
    final base = quantite * prixUnitaire;
    return base - remise - rabais - ristourne;
  }

  double get montantTVA => montantHT * (tva / 100);

  double get montantTTC => montantHT + montantTVA;

  Map<String, dynamic> toJson() => {
        if (id != null) '_id': id,
        'description': description,
        'quantite': quantite,
        'prixUnitaire': prixUnitaire,
        'remise': remise,
        'rabais': rabais,
        'ristourne': ristourne,
        'tva': tva,
        'montantHT': montantHT,
        'montantTVA': montantTVA,
        'montantTTC': montantTTC,
      };

  factory InvoiceLine.fromJson(Map<String, dynamic> json) {
    try {
      return InvoiceLine(
        id: json['_id']?.toString(),
        description: json['description']?.toString() ?? 'Article inconnu',
        quantite: json['quantite']?.toInt() ?? 1,
        prixUnitaire: json['prixUnitaire']?.toDouble() ?? 0.0,
        remise: json['remise']?.toDouble() ?? 0.0,
        rabais: json['rabais']?.toDouble() ?? 0.0,
        ristourne: json['ristourne']?.toDouble() ?? 0.0,
        tva: json['tva']?.toDouble() ?? 0.0,
      );
    } catch (e) {
      print('Erreur InvoiceLine.fromJson: $e');
      throw Exception('Erreur lors du parsing de la ligne: $e');
    }
  }
}

typedef LigneFacture = InvoiceLine;

class Facture {
  String? id;
  String numero;
  FactureType type;
  StatutFacture statut;
  DateTime dateEmission;
  DateTime dateEcheance;
  String clientNom;
  String? clientAdresse;
  String? clientTVA;
  String? siret; // Ajout: SIRET fournisseur
  String? clientSiret; // Ajout: SIRET client
  String? adresseFournisseur; // Ajout: Adresse fournisseur
  String penalitesRetard; // Ajout: Pénalités de retard
  List<LigneFacture> lignes;
  double fraisLivraison;
  double agios;
  double acompte;
  String devise;
  String? invoiceRef;
  String? motifAnnulation;
  String? frequence;
  DateTime? dateFin;
  String? parentInvoice; // Ajout: Lien facture récurrente
  String? revisionPrix; // Ajout: Révision prix récurrente
  String? motifAvoir; // Ajout: Motif pour avoir
  String? creditType; // Ajout: Crédit ou remboursement
  DateTime? validiteDevis; // Ajout: Validité devis
  int version; // Ajout: Version devis
  String? signature; // Ajout: Signature électronique

  Facture({
    this.id,
    required this.numero,
    required this.type,
    required this.statut,
    required this.dateEmission,
    required this.dateEcheance,
    required this.clientNom,
    this.clientAdresse,
    this.clientTVA,
    this.siret,
    this.clientSiret,
    this.adresseFournisseur,
    this.penalitesRetard = "40 € + taux BCE + 3%",
    required this.lignes,
    this.fraisLivraison = 0.0,
    this.agios = 0.0,
    this.acompte = 0.0,
    this.devise = 'XOF',
    this.invoiceRef,
    this.motifAnnulation,
    this.frequence,
    this.dateFin,
    this.parentInvoice,
    this.revisionPrix,
    this.motifAvoir,
    this.creditType,
    this.validiteDevis,
    this.version = 1,
    this.signature,
  });

  // Sanitization pour XSS
  String sanitize(String input) {
    final document = parse(input);
    return document.body?.text ?? input;
  }

  double get sousTotalHT => lignes.fold(0.0, (sum, ligne) => sum + ligne.montantHT);

  double get totalTVA => lignes.fold(0.0, (sum, ligne) => sum + ligne.montantTVA);

  double get totalTTC {
    var total = sousTotalHT + totalTVA + fraisLivraison + agios - acompte;
    if (type == FactureType.avoir) total *= -1;
    return total;
  }

  double get resteAPayer => totalTTC - acompte;

  Map<String, dynamic> toJson() => {
        if (id != null) '_id': id,
        'numero': numero,
        'type': type.name,
        'statut': statut.name,
        'dateEmission': dateEmission.toIso8601String(),
        'dateEcheance': dateEcheance.toIso8601String(),
        'clientNom': clientNom,
        'clientAdresse': clientAdresse,
        'clientTVA': clientTVA,
        'siret': siret,
        'clientSiret': clientSiret,
        'adresseFournisseur': adresseFournisseur,
        'penalitesRetard': penalitesRetard,
        'lignes': lignes.map((ligne) => ligne.toJson()).toList(),
        'fraisLivraison': fraisLivraison,
        'agios': agios,
        'acompte': acompte,
        'devise': devise,
        'invoiceRef': invoiceRef,
        'motifAnnulation': motifAnnulation,
        'frequence': frequence,
        'dateFin': dateFin?.toIso8601String(),
        'parentInvoice': parentInvoice,
        'revisionPrix': revisionPrix,
        'motifAvoir': motifAvoir,
        'creditType': creditType,
        'validiteDevis': validiteDevis?.toIso8601String(),
        'version': version,
        'signature': signature,
        'sousTotalHT': sousTotalHT,
        'totalTVA': totalTVA,
        'totalTTC': totalTTC,
        'resteAPayer': resteAPayer,
      };

  factory Facture.fromJson(Map<String, dynamic> json) {
    try {
      return Facture(
        id: json['_id']?.toString(),
        numero: json['numero']?.toString() ?? 'N/A',
        type: FactureType.values.firstWhere(
          (e) => e.name == json['type']?.toString(),
          orElse: () => FactureType.standard,
        ),
        statut: StatutFacture.values.firstWhere(
          (e) => e.name == json['statut']?.toString(),
          orElse: () => StatutFacture.brouillon,
        ),
        dateEmission: json['dateEmission'] != null
            ? DateTime.tryParse(json['dateEmission']) ?? DateTime.now()
            : DateTime.now(),
        dateEcheance: json['dateEcheance'] != null
            ? DateTime.tryParse(json['dateEcheance']) ?? DateTime.now().add(const Duration(days: 30))
            : DateTime.now().add(const Duration(days: 30)),
        clientNom: parse(json['clientNom']?.toString() ?? 'Client inconnu').body?.text ?? 'Client inconnu',
        clientAdresse: json['clientAdresse']?.toString(),
        clientTVA: json['clientTVA']?.toString(),
        siret: json['siret']?.toString(),
        clientSiret: json['clientSiret']?.toString(),
        adresseFournisseur: json['adresseFournisseur']?.toString(),
        penalitesRetard: json['penalitesRetard']?.toString() ?? "40 € + taux BCE + 3%",
        lignes: (json['lignes'] as List<dynamic>?)
                ?.map((l) => LigneFacture.fromJson(l as Map<String, dynamic>))
                .toList() ??
            [],
        fraisLivraison: json['fraisLivraison']?.toDouble() ?? 0.0,
        agios: json['agios']?.toDouble() ?? 0.0,
        acompte: json['acompte']?.toDouble() ?? 0.0,
        devise: json['devise']?.toString() ?? 'XOF',
        invoiceRef: json['invoiceRef']?.toString(),
        motifAnnulation: parse(json['motifAnnulation']?.toString() ?? '').body?.text,
        frequence: json['frequence']?.toString(),
        dateFin: json['dateFin'] != null ? DateTime.tryParse(json['dateFin']) : null,
        parentInvoice: json['parentInvoice']?.toString(),
        revisionPrix: json['revisionPrix']?.toString(),
        motifAvoir: parse(json['motifAvoir']?.toString() ?? '').body?.text,
        creditType: json['creditType']?.toString(),
        validiteDevis: json['validiteDevis'] != null ? DateTime.tryParse(json['validiteDevis']) : null,
        version: json['version']?.toInt() ?? 1,
        signature: json['signature']?.toString(),
      );
    } catch (e) {
      print('Erreur Facture.fromJson: $e');
      throw Exception('Erreur lors du parsing de la facture: $e');
    }
  }
}


