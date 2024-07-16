import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../entity/house_stuff_result_entity.dart';
import '../repository/main_repository.dart';

class GetHouseStuffUsecase extends UseCase<HouseStuffResultEntity, NoParams >{
  final MainRepository mainRepository;

  GetHouseStuffUsecase(this.mainRepository);
  @override
  Future<Either<AppError, HouseStuffResultEntity>> call(params) {
    return mainRepository.getHouseStuff();
  }
}


// class GetHouseStuffUsecaseParams{
//   final String title;
//   final int id ;
//   final String description;
//   final String image;
//
//   GetHouseStuffUsecaseParams({required this.title, required this.id, required this.description, required this.image});
//
// }