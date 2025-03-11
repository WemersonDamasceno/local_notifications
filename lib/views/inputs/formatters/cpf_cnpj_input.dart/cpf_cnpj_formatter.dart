import 'package:flutter/services.dart';
import 'package:notifications_firebase/views/inputs/extensions/extension_string.dart';

class CpfCnpjFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.removeNonDigits;
    bool isCpf = text.length <= 11;

    text = isCpf ? formatCpf(text) : formatCnpj(text);

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  String formatCpf(String cpf) {
    final text = cpf.substring(0, cpf.length.clamp(0, 11));

    final patterns = [
      if (text.length > 3) '${text.substring(0, 3)}.',
      if (text.length > 6) '${text.substring(3, 6)}.',
      if (text.length > 9) '${text.substring(6, 9)}-',
      text.length > 3
          ? text.substring(text.length > 6 ? (text.length > 9 ? 9 : 6) : 3)
          : text,
    ];

    return patterns.join();
  }

  String formatCnpj(String cnpj) {
    final text = cnpj.substring(0, cnpj.length.clamp(0, 14));

    final patterns = [
      if (text.length > 2) '${text.substring(0, 2)}.',
      if (text.length > 5) '${text.substring(2, 5)}.',
      if (text.length > 8) '${text.substring(5, 8)}/',
      if (text.length > 12) '${text.substring(8, 12)}-',
      text.length > 2
          ? text.substring(text.length > 5
              ? (text.length > 8 ? (text.length > 12 ? 12 : 8) : 5)
              : 2)
          : text,
    ];

    return patterns.join();
  }
}
