import '../entity/house_selling_type_result_entity.dart';
import 'house_selling_type_model.dart';

class HouseSellingTypeResultModel extends HouseSellingTypeResultEntity {
  const HouseSellingTypeResultModel({required super.houseSellingType});

  factory HouseSellingTypeResultModel.fromJson(
      List<dynamic> jsonList, {
        String locale = 'en',
      }) {
    return HouseSellingTypeResultModel(
      houseSellingType: jsonList
          .map((e) => HouseSellingTypeModel.fromJson(e as Map<String, dynamic>, locale: locale))
          .toList(),
    );
  }


}
