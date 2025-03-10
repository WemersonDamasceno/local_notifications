import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/dynamic_input/phone_or_email_formatter.dart';

class CustomInputWidget extends StatefulWidget {
  final TextEditingController controller;

  const CustomInputWidget({super.key, required this.controller});

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      inputFormatters: [PhoneOrEmailFormatter()],
      decoration: const InputDecoration(
        labelText: 'Digite um e-mail ou telefone',
        border: OutlineInputBorder(),
      ),
    );
  }
}
