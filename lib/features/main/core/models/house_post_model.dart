
import '../entity/house_post_entity.dart';


class HousePostModel extends HousePostEntity {
  const HousePostModel({
    required super.features,
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
    required super.beds,
    required super.bathrooms,
    required super.guests,
    required super.isFavorite, required super.bedrooms,
  });
  factory HousePostModel.fromEntity(HousePostEntity entity) {
    return HousePostModel(
      features: entity.features,
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
      beds: entity.beds,
      bathrooms: entity.bathrooms,
      guests: entity.guests,
      isFavorite: entity.isFavorite, bedrooms: entity.bedrooms,
    );
  }

  factory HousePostModel.fromJson(Map<String, dynamic> json) {
    return HousePostModel(
      features: json["features"],
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
      beds: json['square'],
      bathrooms: json['bathrooms'],
      guests: json['rooms'],
      isFavorite: json['isFavorite'], bedrooms: json["bedrooms"],
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
      'square': beds,
      'bathrooms': bathrooms,
      'rooms': guests,
      'isFavorite': isFavorite,
      'bedrooms':bedrooms,
      'features':features
    };
  }



}