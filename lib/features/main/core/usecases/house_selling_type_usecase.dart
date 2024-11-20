import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../entity/house_selling_type_result_entity.dart';

import '../repository/main_repository.dart';

class GetHouseSellingTypeUsecase extends UseCase<HouseSellingTypeResultEntity, GetHouseSellingTypeParams >{
  final MainRepository mainRepository;

  GetHouseSellingTypeUsecase(this.mainRepository);
  @override
  Future<Either<AppError, HouseSellingTypeResultEntity>> call(GetHouseSellingTypeParams params) {
    return mainRepository.getHouseSellingType(params.locale);
  }
}


class GetHouseSellingTypeParams{
  final String locale;

  GetHouseSellingTypeParams({ required this.locale});



}