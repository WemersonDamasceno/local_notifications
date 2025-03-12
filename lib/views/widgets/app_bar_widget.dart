import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF71207a),
      foregroundColor: Colors.white,
      actions: const [
        Icon(Icons.notifications, color: Colors.white),
      ],
    );
  }
}
