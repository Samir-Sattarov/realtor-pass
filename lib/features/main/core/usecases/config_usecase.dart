import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../entity/config_entity.dart';
import '../repository/main_repository.dart';

class GetConfigUsecase extends UseCase<ConfigEntity, NoParams> {
  final MainRepository repository;

  GetConfigUsecase(this.repository);
  @override
  Future<Either<AppError, ConfigEntity>> call(NoParams params) {
    return repository.getConfig();
  }
}
