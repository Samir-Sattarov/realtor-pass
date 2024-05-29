import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../entity/few_steps_result_entity.dart';
import '../repository/main_repository.dart';

class GetFewStepsUsecase extends UseCase<FewStepsResultEntity, NoParams> {
  final MainRepository repository;

  GetFewStepsUsecase( this.repository);
  @override
  Future<Either<AppError, FewStepsResultEntity>> call(NoParams params) {
    return repository.getFewSteps();
  }
}
