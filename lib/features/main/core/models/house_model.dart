import 'package:realtor_pass/features/main/core/entity/house_entity.dart';

// ignore: must_be_immutable
class HouseModel extends HouseEntity {
  HouseModel(
      {required super.id,
      required super.houseLocation,
      required super.isFavorite,
      required super.houseType,
      required super.category,
      required super.categoryId,
      required super.description,
      required super.images,
      required super.lat,
      required super.lon,
      required super.price,
      required super.square,
      required super.bathroom,
      required super.rooms,
      required super.houseTitle});

  factory HouseModel.fromEntity(HouseEntity entity) {
    return HouseModel(
      id: entity.id,
      houseTitle: entity.houseTitle,
      houseLocation: entity.houseLocation,
      isFavorite: entity.isFavorite,
      houseType: entity.houseType,
      category: entity.category,
      categoryId: entity.categoryId,
      description: entity.description,
      images: List<String>.from(entity.images),
      price: entity.price,
      square: entity.square,
      bathroom: entity.bathroom,
      rooms: entity.rooms,
      lat: entity.lat,
      lon: entity.lon,
    );
  }
  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json["id"],
      houseTitle: json["houseTitle"],
      houseLocation: json["houseLocation"],
      isFavorite: json["isFavorite"],
      houseType: json["houseType"],
      category: json["category"],
      categoryId: json["categoryId"],
      description: json["description"],
      images: List<String>.from(List<Map<String, dynamic>>.from(json['images'])
          .map((Map<String, dynamic> e) => e["url"])
          .toList()),
      price: json["price"],
      square: json["square"],
      bathroom: json["bathroom"],
      rooms: json["rooms"],
      lon: json["lon"],
      lat: json["lat"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "houseLocation": houseLocation,
      "isFavorite": isFavorite,
      "houseType": houseType,
      "category": category,
      "categoryId": categoryId,
      "description": description,
      "images": images.map((image) => {'url': image}).toList(),
      "price": price,
      "square": square,
      "bathroom": bathroom,
      "rooms": rooms,
      "lat": lat,
      "lon": lon
    };
  }

  @override
  String toString() {
    return houseType;
  }
}
