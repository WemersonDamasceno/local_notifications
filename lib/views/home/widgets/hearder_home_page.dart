import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_loading_widget.dart';
import 'package:notifications_firebase/views/home/widgets/user_info_success_widget.dart';

class HearderHomePage extends StatelessWidget {
  const HearderHomePage({super.key, required this.screenEnum});
  final StatusScreenEnum screenEnum;

  @override
  Widget build(BuildContext context) {
    switch (screenEnum) {
      case StatusScreenEnum.loading:
        return const UserInfoLoadingWidget();
      default:
        return const UserInfoSuccessWidget(
          userName: 'Antonio Junior',
          userCnpj: '37.935.960/0001-53',
          userBalance: 221.3,
        );
    }
  }
}
