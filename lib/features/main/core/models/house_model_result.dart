import 'package:realtor_pass/features/main/core/entity/house_result_entity.dart';
import 'package:realtor_pass/features/main/core/models/house_model.dart';

class HouseResultModel extends HouseResultEntity {
  const HouseResultModel({required super.houses});
  factory HouseResultModel.fromJson(Map<String, dynamic> json) {
    return HouseResultModel(
        houses:
            List.of(json["data"]).map((e) => HouseModel.fromJson(e)).toList());
  }
}