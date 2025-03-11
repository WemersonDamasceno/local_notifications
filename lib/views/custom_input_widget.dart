import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputWidget extends StatelessWidget {
  final List<TextInputFormatter> formatters;
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;

  const CustomInputWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.formatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      inputFormatters: formatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        suffix: GestureDetector(
          child: const Icon(Icons.clear),
          onTap: () => controller.clear(),
        ),
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
