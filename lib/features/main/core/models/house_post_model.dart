
import '../entity/house_post_entity.dart';


class HousePostModel extends HousePostEntity {
  const HousePostModel({
    required super.id,
    required super.title,
    required super.location,
    required super.lat,
    required super.lon,
    required super.type,
    required super.category,
    required super.description,
    required super.images,
    required super.price,
    required super.square,
    required super.bathrooms,
    required super.rooms,
    required super.isFavorite,
  });
  factory HousePostModel.fromEntity(HousePostEntity entity) {
    return HousePostModel(
      id: entity.id,
      title: entity.title,
      location: entity.location,
      lat: entity.lat,
      lon: entity.lon,
      type: entity.type,
      category: entity.category,
      description: entity.description,
      images: entity.images,
      price: entity.price,
      square: entity.square,
      bathrooms: entity.bathrooms,
      rooms: entity.rooms,
      isFavorite: entity.isFavorite,
    );
  }

  factory HousePostModel.fromJson(Map<String, dynamic> json) {
    return HousePostModel(
      id: json['id'],
      title: json['title'],
      location: json['location'],
      lat: json['lat'],
      lon: json['lon'],
      type: json['type'],
      category: json['category'],
      description: json['description'],
      images: List<String>.from(json['images']),
      price: json['price'],
      square: json['square'],
      bathrooms: json['bathrooms'],
      rooms: json['rooms'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'lat': lat,
      'lon': lon,
      'type': type,
      'category': category,
      'description': description,
      'images': images,
      'price': price,
      'square': square,
      'bathrooms': bathrooms,
      'rooms': rooms,
      'isFavorite': isFavorite,
    };
  }



}