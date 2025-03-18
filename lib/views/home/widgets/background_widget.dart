import 'package:flutter/material.dart';
import 'package:notifications_firebase/utils/extensions/media_query_extension.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: context.isSmallScreen
              ? context.screenSize.height * 0.45
              : context.screenSize.height * 0.28,
          color: const Color(0xff77127b),
        ),
        Container(
          height: context.screenSize.height * 0.90,
          width: double.infinity,
          color: const Color(0xFFf8f9f9),
        ),
      ],
    );
  }
}
