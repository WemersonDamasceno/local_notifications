import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/widgets/custom_buttom_widget.dart';

class BalanceErrorWidget extends StatelessWidget {
  final VoidCallback refreshBalance;

  const BalanceErrorWidget({
    super.key,
    required this.refreshBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saldo:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              'Erro ao atualizar o saldo.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
        CustomButtonWidget.withIcon(
          title: 'Atualizar',
          icon: const Icon(Icons.refresh),
          backgroundColor: const Color(0xFF2A5595),
          onPressed: () => refreshBalance,
        ),
      ],
    );
  }
}
