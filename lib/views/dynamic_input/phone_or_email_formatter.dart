import 'package:flutter/services.dart';
import 'package:notifications_firebase/views/dynamic_input/extension_string.dart';

class PhoneOrEmailFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    if (text.containsLetter) {
      text = text.removeSpecialCharacters;
    } else {
      text = text.removeNonDigits;
      text = _formatPhoneNumber(text);
    }

    return TextEditingValue(
      text: text,
      selection: newValue.selection.copyWith(
        baseOffset: text.length,
        extentOffset: text.length,
      ),
    );
  }

  /// Formata um número de telefone
  String _formatPhoneNumber(String text) {
    text = text.substring(0, text.length.clamp(0, 11));

    final patterns = [
      if (text.length > 2) '(${text.substring(0, 2)}) ',
      if (text.length > 7) '${text.substring(2, 7)}-',
      text.length > 2 ? text.substring(text.length > 7 ? 7 : 2) : text,
    ];

    return patterns.join();
  }
}
