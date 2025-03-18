import 'package:flutter/material.dart';
import 'package:notifications_firebase/utils/extensions/balance.extension.dart';
import 'package:notifications_firebase/views/widgets/custom_buttom_widget.dart';

class BalanceWidget extends StatelessWidget {
  final double balance;
  final VoidCallback refreshBalance;
  final VoidCallback buyCredits;

  const BalanceWidget({
    super.key,
    required this.balance,
    required this.refreshBalance,
    required this.buyCredits,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saldo:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Text(
                  balance.toBRL(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 21,
                  ),
                  onTap: () => refreshBalance,
                ),
              ],
            )
          ],
        ),
        CustomButtonWidget(
          title: 'Gerenciar conta',
          sizeButton: const Size(130, 46),
          backgroundColor: const Color(0xFF0FAC67),
          onPressed: () => buyCredits,
        ),
      ],
    );
  }
}
