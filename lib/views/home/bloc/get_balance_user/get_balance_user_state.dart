import 'package:equatable/equatable.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/models/balance_user_model.dart';

class GetBalanceUserState extends Equatable {
  final StatusScreenEnum statusScreen;
  final BalanceUserModel? balanceUserModel;

  const GetBalanceUserState({
    this.statusScreen = StatusScreenEnum.initial,
    this.balanceUserModel,
  });

  GetBalanceUserState copyWith({
    StatusScreenEnum? statusScreen,
    BalanceUserModel? balanceUserModel,
  }) {
    return GetBalanceUserState(
      statusScreen: statusScreen ?? this.statusScreen,
      balanceUserModel: balanceUserModel ?? this.balanceUserModel,
    );
  }

  @override
  List<Object?> get props => [statusScreen, balanceUserModel];
}
