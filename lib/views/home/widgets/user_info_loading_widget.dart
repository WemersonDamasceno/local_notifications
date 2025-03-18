import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/widgets/shimmer_base.dart';

class UserInfoLoadingWidget extends StatelessWidget {
  const UserInfoLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerItem.primaryColor(width: 220, height: 20),
          const SizedBox(height: 8),
          ShimmerItem.primaryColor(width: 120, height: 20),
          const SizedBox(height: 16),
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
      ),
    );
  }
}
