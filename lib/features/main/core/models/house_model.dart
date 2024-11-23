
// ignore: must_be_immutable
import '../entity/house_entity.dart';

// ignore: must_be_immutable
class HouseModel extends HouseEntity {
  HouseModel({
    required super.beds,
    required super.guests,
    required super.houseTitle,
    required super.id,
    required super.houseLocation,
    required super.isFavorite,
    required super.houseType,
    required super.category,
    required super.categoryId,
    required super.description,
    required super.images,
    required super.lon,
    required super.lat,
    required super.price,
    required super.bedrooms,
    required super.bathrooms,
    required super.rooms,
  });

  factory HouseModel.fromEntity(HouseEntity entity) {
    return HouseModel(
      id: entity.id,
      houseLocation: entity.houseLocation,
      isFavorite: entity.isFavorite,
      houseType: entity.houseType,
      category: entity.category,
      categoryId: entity.categoryId,
      description: entity.description,
      images: List<String>.from(entity.images),
      lat: entity.lat,
      lon: entity.lon,
      price: entity.price,
      bedrooms: entity.bedrooms,
      bathrooms: entity.bathrooms,
      rooms: entity.rooms,
      houseTitle: entity.houseTitle,
      beds: entity.beds,
      guests: entity.guests,
    );
  }

  factory HouseModel.fromJson(Map<String, dynamic> json,
      {required String locale}) {
    final address = json['address'] ?? {};
    final rooms = json['rooms'] ?? {};

    return HouseModel(
      id: json["id"],
      houseTitle: json["title"]?.toString() ?? '',
      houseLocation: address["exactAddress"]?.toString() ?? '',
      isFavorite: json["isFavorite"] ?? false,
      houseType: json["houseType"]?.toString() ?? '',
      category: json["${locale}category"] ?? '',
      categoryId: json["categoryId"] is int
          ? json["categoryId"]
          : int.tryParse(json["categoryId"]?.toString() ?? '0') ?? 0,
      description: json["description"]?.toString() ?? '',
      images: (json['images'] as List?)
              ?.map((e) => e["url"]?.toString() ?? '')
              .where((url) => url.isNotEmpty)
              .toList() ??
          [],
      price: json["price"],
      bedrooms: rooms["bedrooms"] is int
          ? rooms["bedrooms"]
          : int.tryParse(rooms["bedrooms"]?.toString() ?? '0') ?? 0,
      bathrooms: rooms["bathrooms"] is int
          ? rooms["bathrooms"]
          : int.tryParse(rooms["bathrooms"]?.toString() ?? '0') ?? 0,
      rooms: json["${locale}rooms"] is int
          ? json["${locale}rooms"]
          : int.tryParse(json["${locale}rooms"]?.toString() ?? '0') ?? 0,
      beds: rooms["beds"] is int
          ? rooms["beds"]
          : int.tryParse(rooms["beds"]?.toString() ?? '0') ?? 0,
      guests: rooms["guests"] is int
          ? rooms["guests"]
          : int.tryParse(rooms["guests"]?.toString() ?? '0') ?? 0,
      lat: json["lat"] ?? 0,
      lon: json["lng"] ?? 0,
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
      "bedrooms": bedrooms,
      "bathrooms": bathrooms,
      "rooms": rooms,
      "beds": beds,
      "guests": guests,
      "lat": lat,
      "lon": lon,
    };
  }

  @override
  String toString() {
    return houseType;
  }
}
