import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/inputs/formatters/cpf_cnpj_input.dart/cpf_cnpj_formatter.dart';
import 'package:notifications_firebase/views/inputs/formatters/phone_email_formatter/phone_or_email_formatter.dart';
import 'package:notifications_firebase/views/widgets/custom_input_widget.dart';

class InputsPage extends StatefulWidget {
  const InputsPage({super.key});

  @override
  State<InputsPage> createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> {
  final foneEmailController = TextEditingController();
  final cpfCnpjController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appbar - Inputs Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomInputWidget(
                label: 'Fone/Email',
                formatters: [PhoneOrEmailFormatter()],
                controller: foneEmailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomInputWidget(
                label: 'CPF/CNPJ',
                keyboardType: TextInputType.number,
                formatters: [CpfCnpjFormatter()],
                controller: cpfCnpjController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
