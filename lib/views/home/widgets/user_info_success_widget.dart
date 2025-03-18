import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/widgets/balance_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_widget.dart';

class UserInfoSuccessWidget extends StatelessWidget {
  final String userName;
  final String userCnpj;
  final double userBalance;

  const UserInfoSuccessWidget({
    super.key,
    required this.userName,
    required this.userCnpj,
    required this.userBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoWidget(
            userName: userName,
            cnpjOrCpf: userCnpj,
          ),
          const SizedBox(height: 16),
          BalanceWidget(
            balance: userBalance,
            refreshBalance: () {},
            buyCredits: () {},
          ),
        ],
      ),
    );
  }
}
