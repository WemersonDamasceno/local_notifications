import 'package:equatable/equatable.dart';

abstract class GetScoreEvent extends Equatable {}

class GetScore extends GetScoreEvent {
  @override
  List<Object?> get props => [];
}
