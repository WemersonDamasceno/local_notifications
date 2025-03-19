import 'package:equatable/equatable.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';
import 'package:notifications_firebase/views/home/models/user_info_model.dart';

class GetUserInfoState extends Equatable {
  final StatusScreenEnum statusScreen;
  final UserInfoModel? userInfoModel;

  const GetUserInfoState({
    this.statusScreen = StatusScreenEnum.initial,
    this.userInfoModel,
  });

  GetUserInfoState copyWith({
    StatusScreenEnum? statusScreen,
    UserInfoModel? userInfoModel,
  }) {
    return GetUserInfoState(
      statusScreen: statusScreen ?? this.statusScreen,
      userInfoModel: userInfoModel ?? this.userInfoModel,
    );
  }

  @override
  List<Object?> get props => [statusScreen, userInfoModel];
}
