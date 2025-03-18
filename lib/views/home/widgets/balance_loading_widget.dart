import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/widgets/shimmer_base.dart';

class BalanceLoadingWidget extends StatelessWidget {
  const BalanceLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerItem.primaryColor(width: 48, height: 13),
                const SizedBox(height: 8),
                ShimmerItem.primaryColor(width: 80, height: 20),
              ],
            ),
            ShimmerItem.primaryColor(width: 133, height: 41)
          ],
        ),
      ],
    );
  }
}
