import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/score/widgets/score_card.dart';
import 'package:notifications_firebase/views/widgets/app_bar_widget.dart';

class ScorePage extends StatelessWidget {
  final double score;

  const ScorePage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: AppBarWidget(),
      ),
      backgroundColor: const Color(0xFFeff0f0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScoreCard(
              score: score,
              statusScreen: StatusScreenEnum.success,
            ),
          ],
        ),
      ),
    );
  }
}
