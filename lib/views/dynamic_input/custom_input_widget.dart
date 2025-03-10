import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/dynamic_input/phone_formatter.dart';

class CustomInputWidget extends StatefulWidget {
  final TextEditingController controller;

  const CustomInputWidget({super.key, required this.controller});

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  bool isEmail = true;

  bool _isEmail(String text) {
    if (text.isEmpty) return true;
    return RegExp(r'[a-zA-Z]').hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: (value) => setState(() => isEmail = _isEmail(value)),
      inputFormatters: isEmail ? [] : [PhoneNumberFormatter()],
      decoration: const InputDecoration(
        labelText: 'Digite um e-mail ou telefone',
        border: OutlineInputBorder(),
      ),
    );
  }
}
