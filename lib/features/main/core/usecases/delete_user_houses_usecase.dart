import 'package:dartz/dartz.dart';

import '../../../../app_core/entities/app_error.dart';
import '../../../../app_core/usecases/usecase.dart';
import '../repository/main_repository.dart';

class DeleteUserHousesUsecase extends UseCase<void, DeleteUserUsecaseParams> {
  final MainRepository repository;

  DeleteUserHousesUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(DeleteUserUsecaseParams params) {
    return repository.deleteUserHouse(params.publicationsId);
  }
}



class DeleteUserUsecaseParams {
  final int publicationsId;

  DeleteUserUsecaseParams({required this.publicationsId});
}