import '../entity/house_stuff_result_entity.dart';
import 'house_stuff_model.dart';

class HouseStuffResultModel extends HouseStuffResultEntity {
  const HouseStuffResultModel({required super.houseStuff});

  factory HouseStuffResultModel.fromJson(
    Map<String, dynamic> json, {
    String locale = 'en',
  }) {
    return HouseStuffResultModel(
      houseStuff: List.of(json["data"])
          .map((e) => HouseStuffModel.fromJson(e, locale: locale))
          .toList(),
    );
  }
}
