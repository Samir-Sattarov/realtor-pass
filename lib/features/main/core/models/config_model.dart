import '../entity/config_entity.dart';

class ConfigModel extends ConfigEntity {
  const ConfigModel(
      {required super.redirectLink,
      required super.priceMin,
      required super.priceMax,
      required super.floorsMin,
      required super.floorsMax,
      required super.squareMin,
      required super.squareMax,
      required super.roomsMin,
      required super.roomsMax,
      required super.windowsMin,
      required super.windowsMax});
  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      redirectLink: json['redirectLink'],
      priceMin: json['priceMin'],
      priceMax: json['priceMax'],
      floorsMin: json['gasMin'],
      floorsMax: json['gasMax'],
      squareMin: json['mileageMin'],
      squareMax: json['mileageMax'],
      roomsMin: json['speedMin'],
      roomsMax: json['speedMax'],
      windowsMin: json['yearMin'],
      windowsMax: json['yearMax'],
    );
  }
}
