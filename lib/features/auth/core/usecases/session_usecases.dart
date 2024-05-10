import 'package:dartz/dartz.dart';
import '../../../../app_core/app_core_library.dart';
import '../repository/auth_repository.dart';

class CheckActiveSession extends UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  CheckActiveSession(this.authRepository);

  @override
  Future<Either<AppError, bool>> call(NoParams params) =>
      authRepository.checkActiveSession();
}
