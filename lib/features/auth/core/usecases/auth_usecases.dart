import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../../presentation/cubit/auth/auth_sources/auth_sources_cubit.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';


class AuthSourceUsecase extends UseCase<String, AuthSourcesUsecaseParams> {
  final AuthRepository authRepository;

  AuthSourceUsecase(this.authRepository);

  @override
  Future<Either<AppError, String>> call(AuthSourcesUsecaseParams params) =>
      authRepository.authFromSource(params.source);
}

class LoginUsecase extends UseCase<void, LoginUsecaseParams> {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);

  @override
  Future<Either<AppError, void>> call(LoginUsecaseParams params) =>
      authRepository.signIn(email: params.email, password: params.password, role: params.role);
}

class LogOutUsecase extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  LogOutUsecase(this.authRepository);

  @override
  Future<Either<AppError, void>> call(NoParams params) =>
      authRepository.logOut();
}



class AuthSourcesUsecaseParams {
  final AuthSource source;

  AuthSourcesUsecaseParams({required this.source});
}

class LoginUsecaseParams {
  final String email;
  final String password;
  final String role;

  LoginUsecaseParams({required this.email, required this.password, required this.role});
}
