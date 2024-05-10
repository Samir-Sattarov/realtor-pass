import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/usecases/confirm_password_usecase.dart';

part 'confirm_password_state.dart';

class ConfirmPasswordCubit extends Cubit<ConfirmPasswordState> {
  final ConfirmPasswordUsecase confirmPasswordUsecase;
  ConfirmPasswordCubit(this.confirmPasswordUsecase)
      : super(ConfirmPasswordInitial());

  confirm(String password, String email) async {
    emit(ConfirmPasswordLoading());

    final response = await confirmPasswordUsecase
        .call(ConfirmPasswordUsecaseParams(password: password, email: email));

    response.fold(
      (l) => emit(ConfirmPasswordError(l.errorMessage)),
      (r) => emit(ConfirmPasswordSuccess()),
    );
  }
}
