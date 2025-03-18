import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/widgets/shimmer_base.dart';

class ScoreLoadingWidget extends StatelessWidget {
  const ScoreLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerItem.secondaryColor(width: 160, height: 20),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShimmerItem.secondaryColor(width: 75, height: 50),
            const SizedBox(width: 8),
            ShimmerItem.secondaryColor(width: 60, height: 30),
          ],
        ),
        const SizedBox(height: 16),
        ShimmerItem.secondaryColor(width: double.infinity, height: 15),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerItem.secondaryColor(width: 25, height: 15),
            ShimmerItem.secondaryColor(width: 25, height: 15),
            ShimmerItem.secondaryColor(width: 25, height: 15),
          ],
        ),
        const SizedBox(height: 16),
        // Center(
        //   child: OutlineButtonWidget(
        //     label: 'Veja como melhorar seu Score',
        //     onPressed: () {},
        //   ),
        // ),
      ],
    );
  }
}
