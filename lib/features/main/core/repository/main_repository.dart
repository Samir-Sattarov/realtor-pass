import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';
import 'package:realtor_pass/features/main/core/datasources/main_remote_data_source.dart';
import 'package:realtor_pass/features/main/core/entity/house_result_entity.dart';
import 'package:realtor_pass/features/main/core/entity/house_type_result_entity.dart';
import '../../../../app_core/entities/app_error.dart';
import '../entity/config_entity.dart';
import '../entity/few_steps_result_entity.dart';
import '../entity/house_post_entity.dart';
import '../entity/house_selling_type_entity.dart';
import '../entity/house_selling_type_result_entity.dart';
import '../entity/house_stuff_result_entity.dart';
import '../entity/porters_entity.dart';
import '../entity/profitable_terms_result_entity.dart';
import '../entity/questions_result_entity.dart';
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
  // Future<Either<AppError, List<String>>> uploadImages(List<File> images);
  Future<Either<AppError, HouseSellingTypeResultEntity>> getHouseSellingType(
      String locale);
}

class MainRepositoryImpl extends MainRepository {
  final MainRemoteDataSource remoteDataSource;

  MainRepositoryImpl(this.remoteDataSource);
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

  // @override
  // Future<Either<AppError, List<String>>> uploadImages(List<File> images) async {
  //   return action(task: remoteDataSource.uploadImages(images));
  // }
}
