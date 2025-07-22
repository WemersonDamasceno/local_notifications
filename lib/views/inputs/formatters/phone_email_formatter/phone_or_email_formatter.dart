import 'package:flutter/services.dart';
import 'package:notifications_firebase/views/inputs/extensions/extension_string.dart';

class PhoneOrEmailFormatter extends TextInputFormatter {
  static const int maxDigits = 11;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    final baseOffset = newValue.selection.baseOffset;

    // EMAIL
    if (newText.containsLetter) {
      final cleaned = newText.removeSpecialCharacters;
      final diff = newText.length - cleaned.length;
      final newOffset = (baseOffset - diff).clamp(0, cleaned.length);

      return TextEditingValue(
        text: cleaned,
        selection: TextSelection.collapsed(offset: newOffset),
      );
    }

    // TELEFONE
    final newDigits = newText.removeNonDigits;
    final oldDigits = oldValue.text.removeNonDigits;

    // Bloqueia se ultrapassar o limite de dígitos
    if (newDigits.length > maxDigits && newDigits.length >= oldDigits.length) {
      return oldValue;
    }

    final formatted = _formatPhoneNumber(newDigits);
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
    text = text.substring(0, text.length.clamp(0, maxDigits));

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
