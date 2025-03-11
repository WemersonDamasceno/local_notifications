# README - Formatadores de Input no Flutter

Este documento explica a lógica por trás dos formatadores de input utilizados no projeto, garantindo que os dados inseridos pelos usuários sigam um formato específico antes de serem processados.

---

## 1. Extensão para Manipulação de Strings

A extensão `StringExtensions` facilita a manipulação de strings, fornecendo métodos úteis para limpeza e verificação de caracteres.

```dart
extension StringExtensions on String {
  /// Verifica se a string contém alguma letra
  bool get containsLetter => RegExp(r'[a-zA-Z]').hasMatch(this);

  /// Remove caracteres especiais como ( ) - e espaços
  String get removeSpecialCharacters => replaceAll(RegExp(r'[()\s-]'), '');

  /// Remove tudo que não for número
  String get removeNonDigits => replaceAll(RegExp(r'\D'), '');
}
```

Essa extensão é utilizada para limpar e formatar dados antes de aplicarmos os formatadores de input.

---

## 2. Formatador de Número de Telefone ou E-mail

A classe `PhoneOrEmailFormatter` verifica se a entrada contém letras (indicando um e-mail) ou apenas números (indicando um telefone). Caso seja um número de telefone, ele é formatado corretamente.

```dart
import 'package:flutter/services.dart';
import 'package:notifications_firebase/views/inputs/extensions/extension_string.dart';

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
```

---

## 3. Formatador de CPF e CNPJ

A classe `CpfCnpjFormatter` identifica automaticamente se o usuário está digitando um CPF (11 dígitos) ou um CNPJ (14 dígitos) e formata o número corretamente.

```dart
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
```

---

## 4. Como Usar os Formatadores

Para aplicar os formatadores nos campos de entrada de um `TextField`, basta adicioná-los ao `inputFormatters`:

```dart
TextField(
  inputFormatters: [PhoneOrEmailFormatter()],
)

TextField(
  inputFormatters: [CpfCnpjFormatter()],
  keyboardType: TextInputType.number,
)
```

---