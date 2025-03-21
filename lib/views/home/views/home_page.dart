import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/bloc/get_balance_user/get_balance_user_bloc.dart';
import 'package:notifications_firebase/views/home/bloc/get_balance_user/get_balance_user_event.dart';
import 'package:notifications_firebase/views/home/bloc/get_score/get_score_bloc.dart';
import 'package:notifications_firebase/views/home/bloc/get_score/get_score_event.dart';
import 'package:notifications_firebase/views/home/bloc/get_user_info/get_user_info_bloc.dart';
import 'package:notifications_firebase/views/home/bloc/get_user_info/get_user_info_event.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/widgets/background_widget.dart';
import 'package:notifications_firebase/views/home/widgets/feature_card_list_widget.dart';
import 'package:notifications_firebase/views/home/widgets/hearder_home_page.dart';
import 'package:notifications_firebase/views/home/widgets/home_app_bar.dart';
import 'package:notifications_firebase/views/score/widgets/score_card.dart';

//SOMENTE PARA TESTES, Remover isso de todos os Widgets
StatusScreenEnum statusScreen = StatusScreenEnum.success;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GetUserInfoBloc _getUserInfoBloc;
  late GetBalanceUserBloc _getBalanceUserBloc;
  late GetScoreBloc _getScoreBloc;

  @override
  void initState() {
    super.initState();

    _getUserInfoBloc = GetUserInfoBloc()..add(GetUserInfo());
    _getBalanceUserBloc = GetBalanceUserBloc()..add(GetBalanceUser());
    _getScoreBloc = GetScoreBloc()..add(GetScore());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8f9f9),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HomeAppBar(),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            const BackgroundWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  HearderHomePage(
                    getUserInfoBloc: _getUserInfoBloc,
                    getBalanceUserBloc: _getBalanceUserBloc,
                  ),
                  ScoreCard(getScoreBloc: _getScoreBloc),
                  const SizedBox(height: 16),
                  FeatureCards(screenEnum: statusScreen),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.check, color: Colors.white),
            onPressed: () {
              setState(() {
                statusScreen = StatusScreenEnum.success;
              });
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.error, color: Colors.white),
            onPressed: () {
              setState(() {
                statusScreen = StatusScreenEnum.error;
              });
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _getBalanceUserBloc.add(GetBalanceUser());
              _getUserInfoBloc.add(GetUserInfo());
            },
          ),
        ],
      ),
    );
  }
}
