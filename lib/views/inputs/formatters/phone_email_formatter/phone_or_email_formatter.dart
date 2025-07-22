import 'package:flutter/services.dart';
import 'package:notifications_firebase/views/inputs/extensions/extension_string.dart';

class PhoneOrEmailFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    final baseOffset = newValue.selection.baseOffset;

    String text = newText;

    // EMAIL
    if (text.containsLetter) {
      final cleaned = text.removeSpecialCharacters;

      // Ajusta posição do cursor se algo foi removido
      final diff = text.length - cleaned.length;
      final newOffset = (baseOffset - diff).clamp(0, cleaned.length);

      return TextEditingValue(
        text: cleaned,
        selection: TextSelection.collapsed(offset: newOffset),
      );
    }

    // TELEFONE
    final onlyDigits = text.removeNonDigits;
    final formatted = _formatPhoneNumber(onlyDigits);

    final offset = _calculateCursorPosition(
      oldValue.text,
      newText,
      formatted,
      baseOffset,
    );

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: offset),
    );
  }

  String _formatPhoneNumber(String text) {
    text = text.substring(0, text.length.clamp(0, 11));

    final patterns = [
      if (text.length > 2) '(${text.substring(0, 2)}) ',
      if (text.length > 7) '${text.substring(2, 7)}-',
      text.length > 2 ? text.substring(text.length > 7 ? 7 : 2) : text,
    ];

    return patterns.join();
  }

  int _calculateCursorPosition(
    String oldText,
    String newText,
    String formatted,
    int baseOffset,
  ) {
    final digitsBeforeCursor =
        newText.substring(0, baseOffset).replaceAll(RegExp(r'\D'), '').length;

    int digitCount = 0;
    for (int i = 0; i < formatted.length; i++) {
      if (RegExp(r'\d').hasMatch(formatted[i])) {
        digitCount++;
      }
      if (digitCount == digitsBeforeCursor) {
        return i + 1;
      }
    }

    return formatted.length;
  }
}
