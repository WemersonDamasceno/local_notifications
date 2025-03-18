import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/widgets/balance_loading_widget.dart';
import 'package:notifications_firebase/views/home/widgets/balance_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_loading_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_widget.dart';
import 'package:notifications_firebase/views/widgets/custom_buttom_widget.dart';

class HearderHomePage extends StatelessWidget {
  const HearderHomePage({super.key, required this.screenEnum});
  final StatusScreenEnum screenEnum;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(builder: (context) {
            switch (screenEnum) {
              case StatusScreenEnum.success:
                return const UserInfoWidget(
                  userName: 'Antonio Junior',
                  cnpjOrCpf: '37.346.765/0001-65',
                );
              case StatusScreenEnum.error:
                return const Text('Error');
              default:
                return const UserInfoLoadingWidget();
            }
          }),
          const SizedBox(height: 16),
          Builder(builder: (context) {
            switch (screenEnum) {
              case StatusScreenEnum.success:
                return BalanceWidget(
                  balance: 231.33,
                  refreshBalance: () {},
                  buyCredits: () {},
                );
              case StatusScreenEnum.error:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Saldo:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Erro ao atualizar o saldo.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    CustomButtonWidget.withIcon(
                      title: 'Atualizar',
                      icon: const Icon(Icons.refresh),
                      backgroundColor: const Color(0xFF2A5595),
                      onPressed: () {},
                    ),
                  ],
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
