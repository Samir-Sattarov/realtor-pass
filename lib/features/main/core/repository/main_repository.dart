import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';
import 'package:realtor_pass/features/main/core/datasources/main_remote_data_source.dart';
import 'package:realtor_pass/features/main/core/entity/house_result_entity.dart';
import 'package:realtor_pass/features/main/core/entity/house_type_result_entity.dart';
import '../../../../app_core/entities/app_error.dart';
import '../../../auth/core/datasources/auth_local_data_source.dart';
import '../datasources/main_local_data_source.dart';
import '../entity/config_entity.dart';
import '../entity/few_steps_result_entity.dart';
import '../entity/house_post_entity.dart';
import '../entity/house_selling_type_result_entity.dart';
import '../entity/house_stuff_result_entity.dart';
import '../entity/porters_entity.dart';
import '../entity/profitable_terms_result_entity.dart';
import '../entity/questions_result_entity.dart';
import '../entity/upload_photo_result_entity.dart';
import '../entity/user_houses_result_entity.dart';
import '../models/favorite_houses_json_model.dart';
import '../models/house_post_model.dart';

abstract class MainRepository {
  Future<Either<AppError, HouseResultEntity>> getHouses(
    String locale,
    int page,
    String search,
    int? houseType,
    int? category,
    int? square,
    int? rooms,
    int? bathroom,
    int? fromYear,
    int? toYear,
    int? maxPrice,
    int? minPrice,
  );
  Future<Either<AppError, HouseTypeResultEntity>> getHouseTypes(String locale);
  Future<Either<AppError, PostersEntity>> getPosters();
  Future<Either<AppError, QuestionsResultEntity>> getQuestions();
  Future<Either<AppError, FewStepsResultEntity>> getFewSteps(String locale);
  Future<Either<AppError, ProfitableTermsResultEntity>> getProfitableTerms();
  Future<Either<AppError, HouseStuffResultEntity>> getHouseStuff(String locale);
  Future<Either<AppError, ConfigEntity>> getConfig();
  Future<Either<AppError, void>> sendFeedback(
    int id,
    String subject,
    String feedback,
  );
  Future<Either<AppError, void>> postHouse(HousePostEntity entity);
  Future<Either<AppError, UploadPhotoResultEntity>> uploadImages(
      List<File> images);
  Future<Either<AppError, HouseSellingTypeResultEntity>> getHouseSellingType(
      String locale);

  Future<Either<AppError, void>> saveHousesToFavorite(int publicationsId);
  Future<Either<AppError, FavoriteHousesJsonModel>> getFavoriteHousesJson();
  Future<Either<AppError, void>> deleteFromFavorite(int carId);
  Future<Either<AppError, void>> deleteAllHousesFromFavorite();
  Future<Either<AppError, HouseResultEntity>> getFavoriteHouses();
  Future<Either<AppError, UserHousesResultEntity>> getUserHouses(
      String locale, int userId);
  Future<Either<AppError, void>> deleteUserHouse(int publicationsId);
}

class MainRepositoryImpl extends MainRepository {
  final MainRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final MainLocalDataSource localDataSource;

  MainRepositoryImpl(
      this.remoteDataSource, this.authLocalDataSource, this.localDataSource);
  @override
  Future<Either<AppError, HouseResultEntity>> getHouses(
      String locale,
      int page,
      String search,
      int? houseType,
      int? category,
      int? square,
      int? rooms,
      int? bathroom,
      int? fromYear,
      int? toYear,
      int? maxPrice,
      int? minPrice) async {
    return action(
        task: remoteDataSource.getHouses(
      locale,
      page,
      search,
      houseType,
      category,
      square,
      rooms,
      bathroom,
      fromYear,
      toYear,
      maxPrice,
      minPrice,
    ));
  }

  @override
  Future<Either<AppError, HouseTypeResultEntity>> getHouseTypes(String locale) {
    return action(
      task: remoteDataSource.getHousesTypes(locale),
    );
  }

  @override
  Future<Either<AppError, PostersEntity>> getPosters() {
    return action<PostersEntity>(
      task: remoteDataSource.getPosters(),
    );
  }

  @override
  Future<Either<AppError, QuestionsResultEntity>> getQuestions() {
    return action(task: remoteDataSource.getQuestions());
  }

  @override
  Future<Either<AppError, FewStepsResultEntity>> getFewSteps(String locale) {
    return action(task: remoteDataSource.getFewSteps(locale));
  }

  @override
  Future<Either<AppError, ProfitableTermsResultEntity>> getProfitableTerms() {
    return action(task: remoteDataSource.getProfitableTerms());
  }

  @override
  Future<Either<AppError, ConfigEntity>> getConfig() {
    return action(task: remoteDataSource.getConfig());
  }

  @override
  Future<Either<AppError, void>> sendFeedback(
      int id, String subject, String feedback) {
    return action(task: remoteDataSource.sendFeedback(id, subject, feedback));
  }

  @override
  Future<Either<AppError, HouseStuffResultEntity>> getHouseStuff(
      String locale) {
    return action(task: remoteDataSource.getHouseStuff(locale));
  }

  @override
  Future<Either<AppError, void>> postHouse(HousePostEntity entity) {
    return action(
        task: remoteDataSource.postHouse(HousePostModel.fromEntity(entity)));
  }

  @override
  Future<Either<AppError, HouseSellingTypeResultEntity>> getHouseSellingType(
      String locale) {
    return action(task: remoteDataSource.getHouseSellingType(locale));
  }

  @override
  Future<Either<AppError, void>> saveHousesToFavorite(
      int publicationsId) async {
    final userId = await authLocalDataSource.getUserId();

    // ignore: void_checks
    if (userId == null) return Right(Future.value(1));

    return action<void>(
      task: remoteDataSource.saveHouseToFavorite(
        userId,
        publicationsId,
      ),
    );
  }

  @override
  Future<Either<AppError, FavoriteHousesJsonModel>>
      getFavoriteHousesJson() async {
    final model = await localDataSource.getFavoriteCars();

    return Right(model);
  }

  @override
  Future<Either<AppError, HouseResultEntity>> getFavoriteHouses() async {
    try {
      final userId = await authLocalDataSource.getUserId();

      if (userId == null) return Right(HouseResultEntity.empty());
      final response = await remoteDataSource.getFavoriteHouses(userId);

      for (var element in response.houses) {
        localDataSource.saveFavoriteHouses(element.id);
      }

      return Right(response);
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorised));
    } on ExceptionWithMessage catch (e) {
      return Left(AppError(
          appErrorType: AppErrorType.msgError, errorMessage: e.message));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> deleteFromFavorite(int carId) async {
    final userId = await authLocalDataSource.getUserId();
    await localDataSource.deleteFavoriteHouse(carId);

    // ignore: void_checks
    if (userId == null) return Right(Future.value(1));

    return action<void>(
      task: remoteDataSource.deleteFromFavorite(
        userId,
        carId,
      ),
    );
  }

  @override
  Future<Either<AppError, void>> deleteAllHousesFromFavorite() async {
    return action(task: localDataSource.deleteAllFavoriteCars());
  }

  @override
  Future<Either<AppError, UploadPhotoResultEntity>> uploadImages(
      List<File> images) async {
    return action<UploadPhotoResultEntity>(
        task: remoteDataSource.uploadImages(images));
  }

  @override
  Future<Either<AppError, UserHousesResultEntity>> getUserHouses(
    String locale,
    int userId,
  ) {
    return action(task: remoteDataSource.getUserHouses(locale, userId));
  }

  @override
  Future<Either<AppError, void>> deleteUserHouse(int publicationsId) {
    return action(task: remoteDataSource.deleteUserHouse(publicationsId));
  }
}
