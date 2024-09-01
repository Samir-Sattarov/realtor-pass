import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../entity/few_steps_result_entity.dart';
import '../repository/main_repository.dart';

class GetFewStepsUsecase extends UseCase<FewStepsResultEntity, ImportantStagesUsecaseParams> {
  final MainRepository repository;

  GetFewStepsUsecase( this.repository);
  @override
  Future<Either<AppError, FewStepsResultEntity>> call(ImportantStagesUsecaseParams params) {
    return repository.getFewSteps(params.locale);
  }
}
class ImportantStagesUsecaseParams{
  final String locale;

  ImportantStagesUsecaseParams({ required this.locale});

}