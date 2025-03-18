import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notifications_firebase/views/widgets/custom_buttom_widget.dart';

class ScoreErrorWidget extends StatelessWidget {
  final VoidCallback onRefresh;

  const ScoreErrorWidget({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * 0.37,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ocorreu um erro ao carregar seu score',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1d4f91),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              CustomButtonWidget.withIcon(
                sizeButton: Size(size.width * 0.38, 40),
                backgroundColor: const Color(0xFF1E437A),
                icon: const Icon(Icons.refresh),
                title: 'Recarregar',
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: size.width * 0.38,
          child: SvgPicture.asset(
            'assets/images/error.svg',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
