import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../entity/user_houses_result_entity.dart';
import '../repository/main_repository.dart';

class GetUserHousesUseCase
    extends UseCase<UserHousesResultEntity, GetUserHousesUsecaseParams> {
  final MainRepository repository;

  GetUserHousesUseCase(this.repository);
  @override
  Future<Either<AppError, UserHousesResultEntity>> call(
      GetUserHousesUsecaseParams params) {
    return repository.getUserHouses(
      params.locale,params.userId
    );
  }
}

class GetUserHousesUsecaseParams {
  final String locale;
  final int userId;

  GetUserHousesUsecaseParams( {
    required this.locale,
    required this.userId
  });
}
