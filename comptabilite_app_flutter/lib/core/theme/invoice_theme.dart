// filepath: /Users/cavris/Desktop/projets/Systheme_Compta_PME/comptabilite_app_flutter/lib/core/theme/invoice_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceTheme {
  static final colors = _InvoiceColors();
  static final textStyles = _InvoiceTextStyles();
  static final decorations = _InvoiceDecorations();
}

class _InvoiceColors {
  final primary = Colors.blue.shade700;
  final secondary = Colors.blue.shade50;
  final success = Colors.green.shade600;
  final error = Colors.red.shade600;
  final warning = Colors.orange.shade600;
  final background = Colors.grey.shade50;
  final required = Colors.red.shade400; // Ajout: Champs obligatoires

  final cardGradient = LinearGradient(
    colors: [Colors.white, Colors.blue.shade50],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class _InvoiceTextStyles {
  final title = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  final subtitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  final body = GoogleFonts.poppins(
    fontSize: 14,
  );

  final amount = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  final stepper = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}

class _InvoiceDecorations {
  final card = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.shade100.withOpacity(0.2),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  );

  final stepper = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: Colors.blue.shade50,
  );
}