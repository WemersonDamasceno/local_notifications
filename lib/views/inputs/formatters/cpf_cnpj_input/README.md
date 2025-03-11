# CpfCnpjValidator

## Descrição

O `CpfCnpjValidator` é uma classe utilitária para validar números de CPF e CNPJ em aplicativos Flutter/Dart. Ele remove caracteres não numéricos, verifica o tamanho adequado e utiliza algoritmos de validação específicos para cada tipo de documento.

## Uso

```dart
import 'package:notifications_firebase/views/inputs/formatters/cpf_cnpj_validator.dart';

void main() {
  print(CpfCnpjValidator.validate("668.446.055-10")); // CPF válido
  print(CpfCnpjValidator.validate("668.446.055-09")); // CPF inválido

  print(CpfCnpjValidator.validate("56.745.926/0001-60")); // CNPJ válido
  print(CpfCnpjValidator.validate("56.745.926/0001-22")); // CNPJ inválido
}
```

## Implementação do Código

### 1. Algoritmo de validação do CPF
```dart
List<int> numbers = cpf.split('').map(int.parse).toList();
```
Transforma a string em uma lista de inteiros para calcular os dígitos verificadores.

```dart
int sum1 = List.generate(9, (i) => numbers[i] * (10 - i)).reduce((a, b) => a + b);
int digit1 = (sum1 * 10 % 11) % 10;
```
Calcula o primeiro dígito verificador com base em um multiplicador decrescente.

```dart
int sum2 = List.generate(10, (i) => numbers[i] * (11 - i)).reduce((a, b) => a + b);
int digit2 = (sum2 * 10 % 11) % 10;
```
Calcula o segundo dígito verificador.

```dart
return digit1 == numbers[9] && digit2 == numbers[10];
```
Verifica se os dígitos calculados correspondem aos do CPF informado.

### 2. Algoritmo de validação do CNPJ
```dart
List<int> firstWeights = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
List<int> secondWeights = [6, ...firstWeights];
```
Define os pesos usados nos cálculos.

```dart
int sum1 = List.generate(12, (i) => numbers[i] * firstWeights[i]).reduce((a, b) => a + b);
int digit1 = (sum1 % 11 < 2) ? 0 : 11 - (sum1 % 11);
```
Calcula o primeiro dígito verificador.

```dart
int sum2 = List.generate(13, (i) => numbers[i] * secondWeights[i]).reduce((a, b) => a + b);
int digit2 = (sum2 % 11 < 2) ? 0 : 11 - (sum2 % 11);
```
Calcula o segundo dígito verificador.

```dart
return digit1 == numbers[12] && digit2 == numbers[13];
```
Verifica se os dígitos calculados correspondem aos do CNPJ informado.

## Referências

- [Validação de CPF/CNPJ](https://www.campuscode.com.br/conteudos/o-calculo-do-digito-verificador-do-cpf-e-do-cnpj)


