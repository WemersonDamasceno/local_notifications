extension StringExtensions on String {
  /// Verifica se a string contém alguma letra
  bool get containsLetter => RegExp(r'[a-zA-Z]').hasMatch(this);

  /// Remove caracteres especiais como ( ) - e espaços
  String get removeSpecialCharacters => replaceAll(RegExp(r'[()\s-]'), '');

  /// Remove tudo que não for número
  String get removeNonDigits => replaceAll(RegExp(r'\D'), '');
}
