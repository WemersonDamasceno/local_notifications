import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/widgets/balance_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_widget.dart';

class HearderHomePage extends StatelessWidget {
  const HearderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.topLeft,
      height: screenHeight * 0.27,
      color: const Color(0xFF71207a),
      padding: const EdgeInsets.all(16.0),
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
