
import '../entity/house_type_result_entity.dart';
import 'house_type_model.dart';

class HouseTypeResultModel extends HouseTypeResultEntity {
  const HouseTypeResultModel({required super.housesType});
  factory HouseTypeResultModel.fromJson(Map<String, dynamic> json, {String locale = 'ru'}) {
    final  categoriesJson = List<dynamic>.from(json['data']  ?? []);
    return HouseTypeResultModel(
        housesType: categoriesJson
            .map((e) => HouseTypeModel.fromJson(e, locale: locale))
            .toList());
  }
}
