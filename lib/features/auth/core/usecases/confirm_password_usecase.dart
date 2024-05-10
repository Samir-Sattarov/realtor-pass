import 'package:dartz/dartz.dart';

import '../../../../app_core/entities/app_error.dart';
import '../../../../app_core/usecases/usecase.dart';
import '../repository/auth_repository.dart';

class ConfirmPasswordUsecase
    extends UseCase<void, ConfirmPasswordUsecaseParams> {
  final AuthRepository authRepository;

  ConfirmPasswordUsecase(this.authRepository);

  @override
  Future<Either<AppError, void>> call(ConfirmPasswordUsecaseParams params) =>
      authRepository.confirmPassword(params.password, params.email);
}

class ConfirmPasswordUsecaseParams {
  final String password;
  final String email;
  ConfirmPasswordUsecaseParams({required this.password, required this.email});
}
