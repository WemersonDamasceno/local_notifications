import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (text.length > 11) {
      text = text.substring(0, 11);
    }

    String formattedText;
    if (text.length <= 2) {
      formattedText = text;
    } else if (text.length <= 7) {
      formattedText = '(${text.substring(0, 2)}) ${text.substring(2)}';
    } else {
      formattedText =
          '(${text.substring(0, 2)}) ${text.substring(2, 7)}-${text.substring(7)}';
    }

    TextSelection newSelection = newValue.selection.copyWith(
      baseOffset: formattedText.length,
      extentOffset: formattedText.length,
    );

    return TextEditingValue(
      text: formattedText,
      selection: newSelection,
    );
  }
}
