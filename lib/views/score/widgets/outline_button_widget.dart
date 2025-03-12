import 'package:flutter/material.dart';

class OutlineButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const OutlineButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        foregroundColor: const Color(0xFF2e5796),
        side: const BorderSide(
          color: Color(0xFF2e5796),
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: const Text('Veja como melhorar seu Score'),
    );
  }
}
