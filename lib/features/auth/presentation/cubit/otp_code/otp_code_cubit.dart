import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/usecases/confirm_otp_usecase.dart';
import '../current_user/current_user_cubit.dart';
import '../session/session_cubit.dart';

part 'otp_code_state.dart';

class OtpCodeCubit extends Cubit<OtpCodeState> {
  final ConfirmOTPUsecase otpUsecase;
  final ConfirmOTPForEditUserUsecase confirmOTPForEditUserUsecase;
  final CurrentUserCubit currentUserCubit;
  final SessionCubit sessionCubit;

  OtpCodeCubit(
    this.otpUsecase,
    this.currentUserCubit,
    this.confirmOTPForEditUserUsecase,
    this.sessionCubit,
  ) : super(OtpCodeInitial());

  confirmForEditUser(
      {required String code, bool forgotPassword = false}) async {
    emit(OtpCodeLoading());

    final response = await confirmOTPForEditUserUsecase.call(
      ConfirmOtpForEditUserUsecaseParams(
        code: code,
        forgotPassword: forgotPassword,
      ),
    );

    response.fold(
      (l) => emit(OtpCodeError(message: l.errorMessage)),
      (r) {
        emit(OtpCodeSuccess());
      },
    );
  }

  confirm({required String code}) async {
    emit(OtpCodeLoading());

    final response = await otpUsecase(
      ConfirmOtpUsecaseParams(
        code: code,
      ),
    );

    response.fold(
      (l) => emit(OtpCodeError(message: l.errorMessage)),
      (r) {
        sessionCubit.checkSession();
        emit(OtpCodeSuccess());
      },
    );
  }
}
