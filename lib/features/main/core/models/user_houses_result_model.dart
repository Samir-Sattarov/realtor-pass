import '../entity/user_houses_result_entity.dart';
import 'house_model.dart';

class UserHousesResultModel extends UserHousesResultEntity {
  final List<HouseModel> houses;

  const UserHousesResultModel({ required this.houses}) : super(houses: houses);

  factory UserHousesResultModel.fromJson(List<dynamic> jsonList, {required String locale}) {
    List<HouseModel> houses = jsonList.map((json) {
      if (json is Map<String, dynamic>) {
        return HouseModel.fromJson(json, locale: locale);
      } else {
        throw Exception("Invalid house JSON format");
      }
    }).toList();

    return UserHousesResultModel(houses: houses);
  }
}
