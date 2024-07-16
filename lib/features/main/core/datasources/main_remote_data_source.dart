import 'package:realtor_pass/app_core/app_core_library.dart';
import 'package:realtor_pass/features/main/core/models/house_model_result.dart';
import 'package:realtor_pass/features/main/core/models/house_type_result_model.dart';
import '../../../../app_core/utils/test_dates.dart';
import '../models/config_model.dart';
import '../models/few_steps_result_model.dart';
import '../models/house_stuff_result_model.dart';
import '../models/posters_model.dart';
import '../models/profitable_terms_result_model.dart';
import '../models/questions_result_model.dart';

abstract class MainRemoteDataSource {
  Future<HouseResultModel> getHouses(
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
  Future<HouseTypeResultModel> getHousesTypes();
  Future<PostersModel> getPosters();
  Future<HouseStuffResultModel> getHouseStuff();


  Future<QuestionsResultModel> getQuestions();
  Future<FewStepsResultModel> getFewSteps();
  Future<ProfitableTermsResultModel> getProfitableTerms();
  Future<ConfigModel> getConfig();
  Future<void> sendFeedback(int id, String subject, String feedback);

}

class MainRemoteDataSourceImpl extends MainRemoteDataSource {
  final ApiClient apiClient;

  MainRemoteDataSourceImpl(this.apiClient);
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
      "page": page,
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

    // final response = await apiClient.get(ApiConstants.cars, params: params);
    final model = HouseResultModel(houses: TestDates.houses);
    return model;
  }

  @override
  Future<HouseTypeResultModel> getHousesTypes() async {
    final response = await apiClient.get(ApiConstants.carCategories);
    final model = HouseTypeResultModel.fromJson(response);
    return model;
  }

  @override
  Future<PostersModel> getPosters() async {
    // final response = await apiClient.get(ApiConstants.banners);
    final model = PostersModel(images: TestDates.posters.images);
    return model;
  }

  @override
  Future<QuestionsResultModel> getQuestions() async {
    final response = await apiClient.get(ApiConstants.questions);
    final model = QuestionsResultModel.fromJson(response);
    return model;
  }

  @override
  Future<FewStepsResultModel> getFewSteps() async {
    final response = await apiClient.get(ApiConstants.importantStages);
    final model = FewStepsResultModel.fromJson(response);
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
    await apiClient.post(
      ApiConstants.support,
      params: {
        "userId": id,
        "subject": subject,
        "description": feedback,

      }

    );
  }

  @override
  Future<HouseStuffResultModel> getHouseStuff() async {
    // final response = await apiClient.get(ApiConstants.banners);
    final model = HouseStuffResultModel(houseStuff: TestDates.houseStuff);
    return model;
  }
}
