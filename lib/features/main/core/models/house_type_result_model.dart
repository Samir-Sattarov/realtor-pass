import 'package:realtor_pass/features/main/core/entity/house_type_result_entity.dart';
import 'package:realtor_pass/features/main/core/models/house_type_model.dart';

class HouseTypeResultModel extends HouseTypeResultEntity {
  const HouseTypeResultModel({required super.houses});
  factory HouseTypeResultModel.fromJson(Map<String, dynamic> json) {
    return HouseTypeResultModel(
        houses: List<Map<String, dynamic>>.from(json["houses"])
            .map((e) => HouseTypeModel.fromJson(e))
            .toList());
  }
}
