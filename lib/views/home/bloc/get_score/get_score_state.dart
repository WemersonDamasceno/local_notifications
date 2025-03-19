import 'package:equatable/equatable.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/models/score_model.dart';

class GetScoreState extends Equatable {
  final StatusScreenEnum statusScreen;
  final ScoreModel? scoreModel;

  const GetScoreState({
    this.statusScreen = StatusScreenEnum.initial,
    this.scoreModel,
  });

  GetScoreState copyWith({
    StatusScreenEnum? statusScreen,
    ScoreModel? scoreModel,
  }) {
    return GetScoreState(
      statusScreen: statusScreen ?? this.statusScreen,
      scoreModel: scoreModel ?? this.scoreModel,
    );
  }

  @override
  List<Object?> get props => [statusScreen, scoreModel];
}
