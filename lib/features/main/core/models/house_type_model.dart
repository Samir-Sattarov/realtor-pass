import 'package:realtor_pass/features/main/core/entity/house_type_entity.dart';

class HouseTypeModel extends HouseTypeEntity {
  const HouseTypeModel({
    required super.id,
    required super.title,
    required super.image,
  });

  factory HouseTypeModel.fromJson(
    Map<String, dynamic> json, {
    required String locale,
  }) {
    final title = json['${locale}Title'];

    return HouseTypeModel(
      id: json["id"],
      title: title,
      image: json["url"],
    );
  }
}
