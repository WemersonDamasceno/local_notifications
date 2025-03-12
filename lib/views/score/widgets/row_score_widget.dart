import 'package:flutter/material.dart';

class RowScoreWidget extends StatelessWidget {
  const RowScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Color(0xFF626d79),
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("0", style: textStyle),
        Text("500", style: textStyle),
        Text("1000", style: textStyle),
      ],
    );
  }
}
