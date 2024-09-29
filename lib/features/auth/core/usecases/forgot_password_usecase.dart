import 'package:dartz/dartz.dart';

import '../../../../app_core/entities/app_error.dart';
import '../../../../app_core/usecases/usecase.dart';
import '../repository/auth_repository.dart';

class ForgotPasswordUsecase extends UseCase<void, ForgotPasswordUsecaseParams> {
  final AuthRepository authRepository;

  ForgotPasswordUsecase(this.authRepository);

  @override
  Future<Either<AppError, void>> call(ForgotPasswordUsecaseParams params) =>
      authRepository.getCodeForEditUser(params.email);
}

class ForgotPasswordUsecaseParams {
  final String email;
  ForgotPasswordUsecaseParams({required this.email});
}
