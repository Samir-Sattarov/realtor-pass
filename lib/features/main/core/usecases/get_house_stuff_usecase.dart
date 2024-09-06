import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../entity/house_stuff_result_entity.dart';
import '../repository/main_repository.dart';

class GetHouseStuffUsecase extends UseCase<HouseStuffResultEntity, GetHouseStuffUsecaseParams >{
  final MainRepository mainRepository;

  GetHouseStuffUsecase(this.mainRepository);
  @override
  Future<Either<AppError, HouseStuffResultEntity>> call(GetHouseStuffUsecaseParams params) {
    return mainRepository.getHouseStuff(params.locale);
  }
}


class GetHouseStuffUsecaseParams{
  final String locale;

  GetHouseStuffUsecaseParams({ required this.locale});



}