import 'package:flutter/material.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/score/widgets/score_error_widget.dart';
import 'package:notifications_firebase/views/score/widgets/score_loading_widget.dart';
import 'package:notifications_firebase/views/score/widgets/score_success_widget.dart';

class ScoreCard extends StatelessWidget {
  final double score;
  final StatusScreenEnum statusScreen;
  final int maxScore = 1000;

  const ScoreCard({
    super.key,
    required this.score,
    required this.statusScreen,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget body;
    switch (statusScreen) {
      case StatusScreenEnum.success:
        body = ScoreSuccessWidget(score: score);
      case StatusScreenEnum.error:
        body = ScoreErrorWidget(
          onRefresh: () {},
        );
      default:
        body = const ScoreLoadingWidget();
    }

    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.23,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: body,
        ),
      ),
    );
  }
}
