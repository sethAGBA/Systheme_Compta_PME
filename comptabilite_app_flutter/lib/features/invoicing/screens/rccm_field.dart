import 'package:ComptaFacile/core/theme/invoice_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:ComptaFacile/features/invoicing/screens/invoice_theme.dart';

class RccmField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const RccmField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RccmField> createState() => _RccmFieldState();
}

class _RccmFieldState extends State<RccmField> {
  bool _isValid = false;

  bool _validateRccm(String value) {
    final regex = RegExp(r'^(RC|RM)/[A-Z]{2}/[A-Z]{3}/\d{4}/[A-Z]\d{4,5}$');
    return regex.hasMatch(value);
  }

  void _formatAndValidate(String value) {
    String formattedValue = value.toUpperCase();

    // Ajout automatique des séparateurs
    if (formattedValue.length >= 2 && !formattedValue.contains('/')) {
      if (formattedValue.startsWith('RC') || formattedValue.startsWith('RM')) {
        formattedValue = '$formattedValue/';
      }
    } else if (formattedValue.length >= 5 && formattedValue.split('/').length == 2) {
      formattedValue = '$formattedValue/';
    } else if (formattedValue.length >= 9 && formattedValue.split('/').length == 3) {
      formattedValue = '$formattedValue/';
    } else if (formattedValue.length >= 14 && formattedValue.split('/').length == 4) {
      formattedValue = '$formattedValue/';
    }

    if (formattedValue != value) {
      widget.controller.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }

    setState(() {
      _isValid = _validateRccm(formattedValue);
    });
    widget.onChanged(formattedValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'RCCM Client*',
        labelStyle: GoogleFonts.poppins(color: InvoiceTheme.colors.primary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade100,
        helperText: 'Ex: RC/TG/LOM/2023/A00987',
        helperStyle: GoogleFonts.poppins(fontSize: 12),
        errorText: widget.controller.text.isNotEmpty && !_isValid
            ? 'Format RCCM incorrect (ex: RC/TG/LOM/2023/A00987)'
            : null,
        prefixIcon: const Icon(Icons.business),
        suffixIcon: widget.controller.text.isNotEmpty
            ? Icon(
                _isValid ? Icons.check_circle : Icons.error,
                color: _isValid ? Colors.green : Colors.red,
              )
            : null,
      ),
      style: GoogleFonts.poppins(),
      onChanged: _formatAndValidate,
    );
  }
}