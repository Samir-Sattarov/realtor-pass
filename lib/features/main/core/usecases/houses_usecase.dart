import 'package:dartz/dartz.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';
import 'package:realtor_pass/features/main/core/entity/house_result_entity.dart';
import 'package:realtor_pass/features/main/core/entity/house_type_result_entity.dart';
import 'package:realtor_pass/features/main/core/repository/main_repository.dart';

import '../entity/favorite_houses_json_entity.dart';

class GetHousesUsecase extends UseCase<HouseResultEntity, GetHousesUsecaseParams> {
  final MainRepository mainRepository;

  GetHousesUsecase(this.mainRepository);

  @override
  Future<Either<AppError, HouseResultEntity>> call(
      GetHousesUsecaseParams params) {
    return mainRepository.getHouses(
      params.locale,
        params.page,
        params.search,
        params.houseType,
        params.category,
        params.square,
        params.rooms,
        params.bathroom,
        params.fromYear,
        params.toYear,
        params.maxPrice,
        params.minPrice);
  }
}

class GetHouseTypeUsecase extends UseCase<HouseTypeResultEntity, GetHousesTypeUsecaseParams> {
  final MainRepository repository;

  GetHouseTypeUsecase(this.repository);

  @override
  Future<Either<AppError, HouseTypeResultEntity>> call(GetHousesTypeUsecaseParams params) {
    return repository.getHouseTypes(params.locale);
  }
}

class GetFavoriteHouseJsonUsecase extends UseCase<FavoriteHousesJsonEntity, NoParams> {
  final MainRepository repository;

  GetFavoriteHouseJsonUsecase(this.repository);

  @override
  Future<Either<AppError, FavoriteHousesJsonEntity>> call(NoParams params) {
    return repository.getFavoriteHousesJson();
  }
}

class SaveHousesToFavoriteUsecase extends UseCase<void, FavoriteParams> {
  final MainRepository repository;

  SaveHousesToFavoriteUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(FavoriteParams params) {
    return repository.saveHousesToFavorite(params.publicationsID);
  }
}

class GetFavoriteHousesUsecase extends UseCase<HouseResultEntity, NoParams> {
  final MainRepository repository;

  GetFavoriteHousesUsecase(this.repository);

  @override
  Future<Either<AppError, HouseResultEntity>> call(NoParams params) {
    return repository.getFavoriteHouses();
  }
}

class DeleteHousesFromFavoriteUsecase extends UseCase<void, FavoriteParams> {
  final MainRepository repository;

  DeleteHousesFromFavoriteUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(FavoriteParams params) {
    return repository.deleteFromFavorite(params.publicationsID);
  }
}

class DeleteAllHousesFromFavoriteUsecase extends UseCase<void, NoParams> {
  final MainRepository repository;

  DeleteAllHousesFromFavoriteUsecase(this.repository);

  @override
  Future<Either<AppError, void>> call(NoParams params) {
    return repository.deleteAllHousesFromFavorite();
  }
}


class FavoriteParams {
  final int publicationsID;

  FavoriteParams({required this.publicationsID});
}
class GetHousesTypeUsecaseParams{
  final String locale;

  GetHousesTypeUsecaseParams({ required this.locale});
}
class GetHousesUsecaseParams {
  final String locale;
  final int page;
  final String search;
  final int? houseType;
  final int? category;
  final int? square;
  final int? rooms;
  final int? bathroom;
  final int? fromYear;
  final int? toYear;
  final int? maxPrice;
  final int? minPrice;

  GetHousesUsecaseParams( {
    required this.locale,
    required this.page,
    required this.search,
    this.houseType,
    this.category,
    this.square,
    this.rooms,
    this.bathroom,
    this.fromYear,
    this.toYear,
    this.maxPrice,
    this.minPrice,
  });
}
