
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../core/usecases/forgot_password_usecase.dart';
import '../../../core/usecases/user_usecases.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUsecase forgotPasswordUsecase;

  String _email = '';
  String _otpCode = '';

  ForgotPasswordCubit(this.forgotPasswordUsecase)
      : super(ForgotPasswordInitial());

  // Сохраняем email
  void saveEmail(String email) {
    _email = email;
  }

  // Получаем email
  String get email => _email;

  // Сохраняем OTP
  void saveOtp(String code) {
    _otpCode = code;
  }

  // Получаем OTP
  String get otpCode => _otpCode;

  Future<void> getCode({required String email, required String role, bool isMobile = true}) async {
    emit(ForgotPasswordLoading());

    final response = await forgotPasswordUsecase.call(
        ForgotPasswordUsecaseParams(email: email, role: role));

    response.fold(
          (l) => emit(ForgotPasswordError(l.errorMessage)),
          (r) {
        saveEmail(email);
        emit(ForgotPasswordSuccess());
      },
    );
  }
}
