import 'package:flutter/services.dart';

class PhoneOrEmailFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    // Quando o texto contém letras, não fazemos a formatação
    if (RegExp(r'[a-zA-Z]').hasMatch(text)) {
      // Remover caracteres especiais como ( ) - e espaços
      text = text.replaceAll(RegExp(r'[()\s-]'), '');
      return TextEditingValue(
        text: text,
        selection: newValue.selection.copyWith(
          baseOffset: text.length,
          extentOffset: text.length,
        ),
      );
    }

    // Se o texto não contiver letras, fazemos a formatação de número de telefone
    // Remove tudo que não for número
    text = text.replaceAll(RegExp(r'\D'), '');

    // Limita o tamanho do número para 11 dígitos
    if (text.length > 11) {
      text = text.substring(0, 11);
    }

    // Aplicar a formatação de telefone
    String formattedText;
    if (text.length <= 2) {
      formattedText = text;
    } else if (text.length <= 7) {
      formattedText = '(${text.substring(0, 2)}) ${text.substring(2)}';
    } else {
      formattedText =
          '(${text.substring(0, 2)}) ${text.substring(2, 7)}-${text.substring(7)}';
    }

    // Ajustar a posição do cursor
    return TextEditingValue(
      text: formattedText,
      selection: newValue.selection.copyWith(
        baseOffset: formattedText.length,
        extentOffset: formattedText.length,
      ),
    );
  }
}
