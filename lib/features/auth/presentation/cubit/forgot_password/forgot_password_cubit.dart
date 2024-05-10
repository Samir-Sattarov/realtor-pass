
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../core/usecases/forgot_password_usecase.dart';
import '../../../core/usecases/user_usecases.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUsecase forgotPasswordUsecase;

  ForgotPasswordCubit(this.forgotPasswordUsecase)
      : super(ForgotPasswordInitial());

  getCode({required String email}) async {
    final response = await forgotPasswordUsecase.call(ForgotPasswordUsecaseParams(email: email));

    response.fold(
      (l) => emit(ForgotPasswordError(l.errorMessage)),
      (r) => emit(ForgotPasswordSuccess()),
    );
  }


}
