import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/inputs/formatters/cpf_cnpj_input/cpf_cnpj_formatter.dart';
import 'package:notifications_firebase/views/inputs/formatters/cpf_cnpj_input/cpf_cnpj_validator.dart';
import 'package:notifications_firebase/views/inputs/formatters/phone_email_formatter/phone_or_email_formatter.dart';
import 'package:notifications_firebase/views/widgets/custom_buttom_widget.dart';
import 'package:notifications_firebase/views/widgets/custom_input_widget.dart';
import 'package:nova_design_system/nova_design_system.dart';

class InputsPage extends StatefulWidget {
  const InputsPage({super.key});

  @override
  State<InputsPage> createState() => _InputsPageState();
}

class _InputsPageState extends State<InputsPage> with UISnackbarMixin {
  final _formKey = GlobalKey<FormState>();
  final foneEmailController = TextEditingController();
  final cpfCnpjController = TextEditingController();
  String? validadeMessage;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showSnackbarSuccess(context: context, message: 'CPF ou CNPJ válido');
      return;
    }

    showSnackbarError(
      context: context,
      message: '${validadeMessage!}, verifique se seus dados estão corretos',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appbar - Inputs Page'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
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
                  validator: (value) {
                    validadeMessage = CpfCnpjValidator.validate(value);
                    return validadeMessage;
                  },
                ),
              ),
              const SizedBox(height: 24),
              CustomButtomWidget(
                onPressed: () => _submitForm(),
                title: 'Enviar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
