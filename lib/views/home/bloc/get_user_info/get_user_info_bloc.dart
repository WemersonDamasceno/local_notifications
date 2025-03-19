import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notifications_firebase/views/home/bloc/get_user_info/get_user_info_event.dart';
import 'package:notifications_firebase/views/home/bloc/get_user_info/get_user_info_state.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';

class GetUserInfoBloc extends Bloc<GetUserInfoEvent, GetUserInfoState> {
  GetUserInfoBloc() : super(const GetUserInfoState()) {
    on<GetUserInfo>(_getUserInfo);
  }

  Future<void> _getUserInfo(
    GetUserInfo event,
    Emitter<GetUserInfoState> emit,
  ) async {
    emit(state.copyWith(statusScreen: StatusScreenEnum.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(statusScreen: StatusScreenEnum.success));
    } catch (_) {
      emit(state.copyWith(statusScreen: StatusScreenEnum.error));
    }
  }
}
