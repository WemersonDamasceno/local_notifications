import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/widgets/balance_widget.dart';
import 'package:notifications_firebase/views/home/widgets/shimmer_base.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_widget.dart';

class HearderHomePage extends StatelessWidget {
  const HearderHomePage({super.key, required this.screenEnum});
  final StatusScreenEnum screenEnum;

  @override
  Widget build(BuildContext context) {
    switch (screenEnum) {
      case StatusScreenEnum.loading:
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
      default:
        return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserInfoWidget(
                userName: 'Antonio Junior',
                cnpjOrCpf: '37.935.960/0001-53',
              ),
              const SizedBox(height: 16),
              BalanceWidget(
                balance: 120.43,
                refreshBalance: () {},
                buyCredits: () {},
              ),
            ],
          ),
        );
    }
  }
}
