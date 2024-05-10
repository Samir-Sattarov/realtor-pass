import 'package:dartz/dartz.dart';
import '../../../../app_core/app_core_library.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

// ================ USE CASSES ================ //

class GetCurrentUserUsecase extends UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  GetCurrentUserUsecase(this.authRepository);

  @override
  Future<Either<AppError, UserEntity>> call(NoParams params) =>
      authRepository.getCurrentUser();
}

class EditCurrentUserUsecase
    extends UseCase<UserEntity, EditCurrentUserParams> {
  final AuthRepository authRepository;

  EditCurrentUserUsecase(this.authRepository);

  @override
  Future<Either<AppError, UserEntity>> call(EditCurrentUserParams params) =>
      authRepository.editCurrentUser(params.user);
}

class GetCodeForEditUserUsecase
    extends UseCase<void, GetCodeForEditUserUsecaseParams> {
  final AuthRepository authRepository;

  GetCodeForEditUserUsecase(this.authRepository);

  @override
  Future<Either<AppError, void>> call(GetCodeForEditUserUsecaseParams params) =>
      authRepository.getCodeForEditUser(params.email);
}

class GetCodeForEditUserUsecaseParams {
  final String email;

  GetCodeForEditUserUsecaseParams({required this.email});
}

class EditCurrentUserParams {
  final UserEntity user;

  EditCurrentUserParams(this.user);
}
