import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/widgets/balance_error_widget.dart';
import 'package:notifications_firebase/views/home/widgets/balance_loading_widget.dart';
import 'package:notifications_firebase/views/home/widgets/balance_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_erro_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_loading_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_widget.dart';

class HearderHomePage extends StatelessWidget {
  final StatusScreenEnum statusScreen;
  const HearderHomePage({super.key, required this.statusScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //BloC para buscar os dados do usuário
          Builder(builder: (context) {
            switch (statusScreen) {
              case StatusScreenEnum.success:
                return const UserInfoWidget(
                  userName: 'Antonio Junior',
                  cnpjOrCpf: '37.346.765/0001-65',
                );
              case StatusScreenEnum.error:
                return UserInfoErroWidget(onRefresh: () {});
              default:
                return const UserInfoLoadingWidget();
            }
          }),
          const SizedBox(height: 16),

          //BloC para buscar o saldo do usuário
          Builder(builder: (context) {
            switch (statusScreen) {
              case StatusScreenEnum.success:
                return BalanceWidget(
                  balance: 231.33,
                  refreshBalance: () {},
                  buyCredits: () {},
                );
              case StatusScreenEnum.error:
                return BalanceErrorWidget(
                  refreshBalance: () {},
                );
              default:
                return const BalanceLoadingWidget();
            }
          }),
        ],
      ),
    );
  }
}
