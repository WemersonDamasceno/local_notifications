import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/widgets/shimmer_base.dart';

class UserInfoLoadingWidget extends StatelessWidget {
  const UserInfoLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerItem.primaryColor(width: 220, height: 20),
        const SizedBox(height: 8),
        ShimmerItem.primaryColor(width: 120, height: 20),
      ],
    );
  }
}
