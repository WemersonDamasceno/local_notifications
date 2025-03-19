import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notifications_firebase/views/home/bloc/get_score/get_score_event.dart';
import 'package:notifications_firebase/views/home/bloc/get_score/get_score_state.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/models/score_model.dart';

class GetScoreBloc extends Bloc<GetScoreEvent, GetScoreState> {
  GetScoreBloc() : super(const GetScoreState()) {
    on<GetScore>(_getScore);
  }

  Future<void> _getScore(
    GetScore event,
    Emitter<GetScoreState> emit,
  ) async {
    emit(state.copyWith(statusScreen: StatusScreenEnum.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
        statusScreen: StatusScreenEnum.success,
        scoreModel: ScoreModel(
          scoreValue: 820,
          scoreStatus: 'Excelente',
          progressBarColor: const Color(0xFF019E44),
          backgroundColorStatus: const Color(0xFFE2F4F0),
          fontColorStatus: const Color(0xFF5E6976),
        ),
      ));
    } catch (_) {
      emit(state.copyWith(statusScreen: StatusScreenEnum.error));
    }
  }
}
