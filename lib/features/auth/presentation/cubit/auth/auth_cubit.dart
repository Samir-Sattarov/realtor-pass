import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app_core/app_core_library.dart';
import '../../../core/usecases/auth_usecases.dart';
import '../current_user/current_user_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase _loginUsecase;
  final LogOutUsecase _logOutUsecase;
  final CurrentUserCubit currentUserCubit;
  AuthCubit(this._loginUsecase,  this.currentUserCubit, this._logOutUsecase)
      : super(AuthInitial());

  signIn({required String email, required String password, required String role}) async {
    emit(AuthLoading());

    final response = await _loginUsecase(
        LoginUsecaseParams(email: email, password: password, role: role));

    response.fold(
      (l) => emit(AuthError(message: l.errorMessage)),
      (r) {
        emit(AuthLoginSuccess());
      },
    );
  }

  getCode({required String email, required String password, required String role}) async {
    emit(AuthLoading());

    final response = await _loginUsecase(
        LoginUsecaseParams(email: email, password: password,role:role ));

    response.fold(
      (l) => emit(AuthError(message: l.errorMessage)),
      (r) {
        emit(AuthLoginSuccess());
      },
    );
  }
  logOut() async {
    final response = await _logOutUsecase.call(NoParams());

    response.fold(
          (l) => emit(AuthError(message: l.errorMessage)),
          (r) => emit(AuthLogOutSuccess()),
    );
  }


}
