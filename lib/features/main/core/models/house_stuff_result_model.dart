import '../entity/house_stuff_result_entity.dart';
import 'house_stuff_models.dart';

class HouseStuffResultModel extends HouseStuffResultEntity {
  const HouseStuffResultModel({required super.houseStuff});
  factory HouseStuffResultModel.fromJson(Map<String, dynamic> json) {
    return HouseStuffResultModel(
        houseStuff:
        List.of(json["data"]).map((e) => HouseStuffModel.fromJson(e)).toList());
  }
}
