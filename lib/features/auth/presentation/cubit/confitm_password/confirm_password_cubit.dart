import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/usecases/confirm_password_usecase.dart';

part 'confirm_password_state.dart';

class ConfirmPasswordCubit extends Cubit<ConfirmPasswordState> {
  final ConfirmPasswordUsecase confirmPasswordUsecase;
  ConfirmPasswordCubit(this.confirmPasswordUsecase)
      : super(ConfirmPasswordInitial());

  confirm(
      {required String password,
      required String token,
      bool isMobile = true}) async {
    emit(ConfirmPasswordLoading());

    final response = await confirmPasswordUsecase.call(
        ConfirmPasswordUsecaseParams(
            password: password, token: token, isMobile: true));

    response.fold(
      (l) => emit(ConfirmPasswordError(l.errorMessage)),
      (r) => emit(ConfirmPasswordSuccess()),
    );
  }
}
