import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/widgets/shimmer_base.dart';

class FeatureCardsLoadingWidget extends StatelessWidget {
  const FeatureCardsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        constraints: const BoxConstraints(minHeight: 110),
        child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerItem.secondaryColor(width: 30, height: 30),
                  const SizedBox(height: 8),
                  ShimmerItem.secondaryColor(width: 265, height: 25)
                ],
              ),
            )),
      ),
    );
  }
}
