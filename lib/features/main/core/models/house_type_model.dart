import 'package:realtor_pass/features/main/core/entity/house_type_entity.dart';

class HouseTypeModel extends HouseTypeEntity {
  const HouseTypeModel({required super.id, required super.title});
  factory HouseTypeModel.fromJson(Map<String, dynamic> json) {
    return HouseTypeModel(id: json["id"], title: json["title"]);
  }
}
