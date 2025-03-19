import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notifications_firebase/views/home/bloc/get_score/get_score_bloc.dart';
import 'package:notifications_firebase/views/home/bloc/get_score/get_score_event.dart';
import 'package:notifications_firebase/views/home/bloc/get_score/get_score_state.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/score/widgets/score_error_widget.dart';
import 'package:notifications_firebase/views/score/widgets/score_loading_widget.dart';
import 'package:notifications_firebase/views/score/widgets/score_success_widget.dart';

class ScoreCard extends StatelessWidget {
  final GetScoreBloc getScoreBloc;
  final int maxScore = 1000;

  const ScoreCard({
    super.key,
    required this.getScoreBloc,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<GetScoreBloc, GetScoreState>(
      bloc: getScoreBloc,
      builder: (context, state) {
        Widget body;
        switch (state.statusScreen) {
          case StatusScreenEnum.success:
            body = ScoreSuccessWidget(score: state.scoreModel!);
          case StatusScreenEnum.error:
            body = ScoreErrorWidget(
              onRefresh: () => getScoreBloc.add(GetScore()),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: body,
            ),
          ),
        );
      },
    );
  }
}
