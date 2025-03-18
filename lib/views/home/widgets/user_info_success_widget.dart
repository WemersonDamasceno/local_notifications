import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/widgets/balance_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_widget.dart';

class UserInfoSuccessWidget extends StatelessWidget {
  final String userName;
  final String userCnpj;
  final double userBalance;
  final VoidCallback buyCredits;
  final VoidCallback refresh;

  const UserInfoSuccessWidget({
    super.key,
    required this.userName,
    required this.userCnpj,
    required this.userBalance,
    required this.buyCredits,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserInfoWidget(
          userName: userName,
          cnpjOrCpf: userCnpj,
        ),
        const SizedBox(height: 16),
        BalanceWidget(
          balance: 231.33,
          refreshBalance: () => refresh(),
          buyCredits: () => buyCredits(),
        ),
      ],
    );
  }
}
