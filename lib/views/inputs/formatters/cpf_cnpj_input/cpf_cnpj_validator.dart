import 'package:notifications_firebase/views/inputs/extensions/extension_string.dart';

class CpfCnpjValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    final cleanValue = value.removeNonDigits;

    if (cleanValue.length == 11) {
      return _validateCpf(cleanValue) ? null : 'CPF inválido';
    } else if (cleanValue.length == 14) {
      return _validateCnpj(cleanValue) ? null : 'CNPJ inválido';
    }

    return 'CPF ou CNPJ inválido';
  }

  static bool _validateCpf(String cpf) {
    List<int> numbers = cpf.split('').map(int.parse).toList();

    int sum1 =
        List.generate(9, (i) => numbers[i] * (10 - i)).reduce((a, b) => a + b);
    int digit1 = (sum1 * 10 % 11) % 10;

    int sum2 =
        List.generate(10, (i) => numbers[i] * (11 - i)).reduce((a, b) => a + b);
    int digit2 = (sum2 * 10 % 11) % 10;

    return digit1 == numbers[9] && digit2 == numbers[10];
  }

  static bool _validateCnpj(String cnpj) {
    List<int> numbers = cnpj.split('').map(int.parse).toList();

    List<int> firstWeights = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    List<int> secondWeights = [6, ...firstWeights];

    int sum1 = List.generate(12, (i) => numbers[i] * firstWeights[i])
        .reduce((a, b) => a + b);
    int digit1 = (sum1 % 11 < 2) ? 0 : 11 - (sum1 % 11);

    int sum2 = List.generate(13, (i) => numbers[i] * secondWeights[i])
        .reduce((a, b) => a + b);
    int digit2 = (sum2 % 11 < 2) ? 0 : 11 - (sum2 % 11);

    return digit1 == numbers[12] && digit2 == numbers[13];
  }
}
