import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../entity/questions_result_entity.dart';
import '../repository/main_repository.dart';

class QuestionsUsecase extends UseCase<QuestionsResultEntity, NoParams> {
  final MainRepository repository;

  QuestionsUsecase(this.repository);
  @override
  Future<Either<AppError, QuestionsResultEntity>> call(NoParams params) {
    return repository.getQuestions();
  }
}
