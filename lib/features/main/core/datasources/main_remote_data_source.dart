import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';
import 'package:realtor_pass/features/main/core/models/house_model_result.dart';
import 'package:realtor_pass/features/main/core/models/house_type_result_model.dart';
import '../../../auth/core/datasources/auth_local_data_source.dart';
import '../models/config_model.dart';
import '../models/few_steps_result_model.dart';
import '../models/house_post_model.dart';
import '../models/house_selling_type_result_model.dart';
import '../models/house_stuff_result_model.dart';
import '../models/posters_model.dart';
import '../models/profitable_terms_result_model.dart';
import '../models/questions_result_model.dart';
import '../models/upload_photo_result_model.dart';

abstract class MainRemoteDataSource {
  Future<HouseResultModel> getHouses(
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
  Future<HouseTypeResultModel> getHousesTypes(String locale);
  Future<PostersModel> getPosters();
  Future<HouseStuffResultModel> getHouseStuff(String locale);
  Future<QuestionsResultModel> getQuestions();
  Future<FewStepsResultModel> getFewSteps(String locale);
  Future<ProfitableTermsResultModel> getProfitableTerms();
  Future<ConfigModel> getConfig();
  Future<void> sendFeedback(int id, String subject, String feedback);
  Future<void> postHouse(HousePostModel model);
  Future<UploadPhotoResultModel> uploadImages(List<File> images);
  Future<HouseSellingTypeResultModel> getHouseSellingType(String locale);
  Future<void> saveHouseToFavorite(int userId, int publicationId);
  Future<HouseResultModel> getFavoriteHouses(int userId);
  Future<void> deleteFromFavorite(int userId, int publicationsId);
}

class MainRemoteDataSourceImpl extends MainRemoteDataSource {
  final ApiClient apiClient;
  final AuthLocalDataSource authLocalDataSource;

  MainRemoteDataSourceImpl(this.apiClient, this.authLocalDataSource);
  Map<String, dynamic> _createRarParams(
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
  ) {
    final params = <String, dynamic>{};

    if (search.isNotEmpty) {
      params['model'] = search;
    }

    if (houseType != null && houseType != 0) {
      params['id'] = houseType;
    }
    if (category != null && category != 0) {
      params['categoryId'] = category;
    }
    if (square != null && square != 0) {
      params['mileage'] = square;
    }
    if (rooms != null && rooms != 0) {
      params['gas'] = rooms;
    }
    if (bathroom != null && bathroom != 0) {
      params['speed'] = bathroom;
    }
    if (fromYear != null) {
      params['yearMin'] = fromYear;
    }
    if (toYear != null) {
      params['yearMax'] = toYear;
    }
    if (maxPrice != null) {
      params['priceMax'] = maxPrice;
    }
    if (minPrice != null) {
      params['priceMin'] = minPrice;
    }

    return params;
  }

  @override
  Future<HouseResultModel> getHouses(
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
  ) async {
    Map<String, dynamic> params = {
      // "page": page,
    };

    final additionalParams = _createRarParams(
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
    );

    params.addAll(additionalParams);

    final response = await apiClient.get(ApiConstants.houses, params: params);
    final model = HouseResultModel.fromJson(response, locale: locale);
    return model;
  }

  @override
  Future<HouseTypeResultModel> getHousesTypes(String locale) async {
    final response = await apiClient.get(ApiConstants.houseCategories);

    log("Response from server categories ${response}");
    final model = HouseTypeResultModel.fromJson(response, locale: locale);
    return model;
  }

  @override
  Future<PostersModel> getPosters() async {
    final response = await apiClient.get(ApiConstants.banners);
    final model = PostersModel.fromJson(response);
    return model;
  }

  @override
  Future<QuestionsResultModel> getQuestions() async {
    final response = await apiClient.get(ApiConstants.questions);
    final model = QuestionsResultModel.fromJson(response);
    return model;
  }

  @override
  Future<FewStepsResultModel> getFewSteps(String locale) async {
    final response = await apiClient.get(ApiConstants.importantStages);
    final model = FewStepsResultModel.fromJson(response, locale: locale);
    return model;
  }

  @override
  Future<ProfitableTermsResultModel> getProfitableTerms() async {
    final response = await apiClient.get(ApiConstants.profitableTerms);
    final model = ProfitableTermsResultModel.fromJson(response);
    return model;
  }

  @override
  Future<ConfigModel> getConfig() async {
    final response = await apiClient.get(ApiConstants.config);
    final model = ConfigModel.fromJson(response);
    return model;
  }

  @override
  Future<void> sendFeedback(int id, String subject, String feedback) async {
    await apiClient.post(ApiConstants.support, params: {
      "userId": id,
      "subject": subject,
      "description": feedback,
    });
  }

  @override
  Future<HouseStuffResultModel> getHouseStuff(String locale) async {
    final response = await apiClient.get(ApiConstants.houseFeatures);
    final model = HouseStuffResultModel.fromJson(response, locale: locale);
    return model;
  }

  @override
  Future<HouseSellingTypeResultModel> getHouseSellingType(String locale) async {
    final response = await apiClient.get(ApiConstants.houseSellingType);
    final model =
        HouseSellingTypeResultModel.fromJson(response, locale: locale);
    return model;
  }

  @override
  Future<void> saveHouseToFavorite(int userId, int publicationId) async {
    await apiClient.post(
      ApiConstants.favoriteHouses,
      params: {
        "userId": userId,
        "publicationId": publicationId,
      },
    );
  }

  @override
  Future<HouseResultModel> getFavoriteHouses(int userId) async {
    final response = await apiClient.get(
      "${ApiConstants.favoriteHouses}/$userId",
    );

    final model = HouseResultModel.fromJson(response);
    return model;
  }

  @override
  Future<void> deleteFromFavorite(int userId, int publicationsId) async {
    await apiClient.deleteWithBody(
      "${ApiConstants.favoriteHouses}/$userId/$publicationsId",
    );
  }

  @override
  Future<UploadPhotoResultModel> uploadImages(List<File> images) async {
    FormData formData = FormData();

    for (File image in images) {
      formData.files.addAll([
        MapEntry(
            "images",
            await MultipartFile.fromFile(image.path,
                filename: image.path.split('/').last))
      ]);
    }

    final response = await apiClient.postPhoto(
      ApiConstants.uploadImages,
      data: formData,
      withParse: false,
      params: {},
    );

    final model = UploadPhotoResultModel.fromJson(response);

    return model;
  }

  @override
  Future<void> postHouse(HousePostModel model) async {
    await apiClient.post(
      ApiConstants.postHouse,
      params: model.toJson(),
    );
  }
}
