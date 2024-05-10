import 'package:dartz/dartz.dart';

import '../../../../app_core/entities/app_error.dart';
import '../../../../app_core/usecases/usecase.dart';
import '../repository/auth_repository.dart';

class RegistrationUsecase extends UseCase<void, RegistrationUsecaseParams> {
  final AuthRepository authRepository;

  RegistrationUsecase(this.authRepository);

  @override
  Future<Either<AppError, void>> call(RegistrationUsecaseParams params) =>
      authRepository.signUp(email: params.email, username: params.username);
}

class RegistrationUsecaseParams {
  final String email;
  final String username;

  RegistrationUsecaseParams({required this.email, required this.username});
}
