import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notifications_firebase/views/home/bloc/get_balance_user/get_balance_user_event.dart';
import 'package:notifications_firebase/views/home/bloc/get_balance_user/get_balance_user_state.dart';
import 'package:notifications_firebase/views/home/enums/status_screen_enum.dart';

class GetBalanceUserBloc
    extends Bloc<GetBalanceUserEvent, GetBalanceUserState> {
  GetBalanceUserBloc() : super(const GetBalanceUserState()) {
    on<GetBalanceUser>(_getBalanceUser);
  }

  Future<void> _getBalanceUser(
    GetBalanceUser event,
    Emitter<GetBalanceUserState> emit,
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
