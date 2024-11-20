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
      redirectLink: json['redirectLink'] ?? '',
      priceMin: json['priceMin'] ?? 0,
      priceMax: json['priceMax'] ?? 0,
      floorsMin: json['floorsMin'] ?? 0,
      floorsMax: json['floorsMax'] ?? 0,
      squareMin: json['squareMin'] ?? 0,
      squareMax: json['squareMax'] ?? 0,
      roomsMin: json['roomsMin'] ?? 0,
      roomsMax: json['roomsMax'] ?? 0,
      windowsMin: json['windowsMin'] ?? 0,
      windowsMax: json['windowsMax'] ?? 0,
    );
  }
}
