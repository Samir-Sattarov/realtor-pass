import 'package:dartz/dartz.dart';
import '../../../../app_core/app_core_library.dart';
import '../entity/porters_entity.dart';
import '../repository/main_repository.dart';

class GetPostersUsecase extends UseCase<PostersEntity, NoParams> {
  final MainRepository repository;

  GetPostersUsecase(this.repository);

  @override
  Future<Either<AppError, PostersEntity>> call(NoParams params) {
    return repository.getPosters();
  }
}
