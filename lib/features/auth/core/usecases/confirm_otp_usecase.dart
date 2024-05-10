import 'package:dartz/dartz.dart';


import '../../../../app_core/entities/app_error.dart';
import '../../../../app_core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class ConfirmOTPUsecase extends UseCase<UserEntity, ConfirmOtpUsecaseParams> {
  final AuthRepository authRepository;

  ConfirmOTPUsecase(this.authRepository);
  @override
  Future<Either<AppError, UserEntity>> call(ConfirmOtpUsecaseParams params) =>
      authRepository.confirmOtp(code: params.code);
}

class ConfirmOTPForEditUserUsecase
    extends UseCase<void, ConfirmOtpForEditUserUsecaseParams> {
  final AuthRepository authRepository;

  ConfirmOTPForEditUserUsecase(this.authRepository);
  @override
  Future<Either<AppError, void>> call(ConfirmOtpForEditUserUsecaseParams params) =>
      authRepository.confirmOTPForEditUser(
          code: params.code, forgotPassword: params.forgotPassword);
}

class ConfirmOtpUsecaseParams {
  final String code;

  ConfirmOtpUsecaseParams({
    required this.code,
  });
}

class ConfirmOtpForEditUserUsecaseParams {
  final String code;
  final bool forgotPassword;

  ConfirmOtpForEditUserUsecaseParams({
    required this.code,
    required this.forgotPassword,
  });
}


