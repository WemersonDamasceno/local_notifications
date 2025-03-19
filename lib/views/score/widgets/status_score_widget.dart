import 'package:flutter/material.dart';

class StatusScoreWidget extends StatelessWidget {
  final String statusScore;
  final Color fontColor;
  final Color backgroundColor;

  const StatusScoreWidget({
    super.key,
    required this.statusScore,
    required this.fontColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusScore,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5e6976),
        ),
      ),
    );
  }
}
