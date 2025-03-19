import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notifications_firebase/views/home/bloc/get_balance_user/get_balance_user_bloc.dart';
import 'package:notifications_firebase/views/home/bloc/get_balance_user/get_balance_user_event.dart';
import 'package:notifications_firebase/views/home/bloc/get_balance_user/get_balance_user_state.dart';
import 'package:notifications_firebase/views/home/bloc/get_user_info/get_user_info_bloc.dart';
import 'package:notifications_firebase/views/home/bloc/get_user_info/get_user_info_state.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/widgets/balance_error_widget.dart';
import 'package:notifications_firebase/views/home/widgets/balance_loading_widget.dart';
import 'package:notifications_firebase/views/home/widgets/balance_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_erro_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_loading_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_widget.dart';

class HearderHomePage extends StatelessWidget {
  const HearderHomePage({
    super.key,
    required this.getUserInfoBloc,
    required this.getBalanceUserBloc,
  });

  final GetUserInfoBloc getUserInfoBloc;
  final GetBalanceUserBloc getBalanceUserBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<GetUserInfoBloc, GetUserInfoState>(
              bloc: getUserInfoBloc,
              builder: (context, state) {
                switch (state.statusScreen) {
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
          BlocBuilder<GetBalanceUserBloc, GetBalanceUserState>(
              bloc: getBalanceUserBloc,
              builder: (context, state) {
                switch (state.statusScreen) {
                  case StatusScreenEnum.success:
                    return BalanceWidget(
                      balance: 231.33,
                      refreshBalance: () {
                        getBalanceUserBloc.add(
                          GetBalanceUser(),
                        );
                      },
                      buyCredits: () {},
                    );
                  case StatusScreenEnum.error:
                    return BalanceErrorWidget(
                      refreshBalance: () {
                        getBalanceUserBloc.add(
                          GetBalanceUser(),
                        );
                      },
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
