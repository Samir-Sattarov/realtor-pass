import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../entity/profitable_terms_result_entity.dart';
import '../repository/main_repository.dart';

class GetProfitableTermsUsecase
    extends UseCase<ProfitableTermsResultEntity, NoParams> {
  final MainRepository repository;

  GetProfitableTermsUsecase(this.repository);
  @override
  Future<Either<AppError, ProfitableTermsResultEntity>> call(NoParams params) {
    return repository.getProfitableTerms();
  }
}
