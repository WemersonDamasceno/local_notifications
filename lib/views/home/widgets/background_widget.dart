import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.29,
          color: const Color(0xff77127b),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.90,
          width: double.infinity,
          color: const Color(0xFFf8f9f9),
        ),
      ],
    );
  }
}
