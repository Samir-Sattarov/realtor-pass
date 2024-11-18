import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/usecases/registration_usecase.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationUsecase registrationUsecase;
  RegistrationCubit(this.registrationUsecase) : super(RegistrationInitial());

  signUp(
      {required String email,
      required String username,
      required String password,
      required String role,
      required String phone}) async {
    emit(RegistrationLoading());
    final response = await registrationUsecase(RegistrationUsecaseParams(
        email: email,
        username: username,
        password: password,
        role: role,
        phone: phone));

    response.fold(
      (l) => emit(RegistrationError(message: l.errorMessage)),
      (r) => emit(RegistrationSuccess()),
    );
  }
}
