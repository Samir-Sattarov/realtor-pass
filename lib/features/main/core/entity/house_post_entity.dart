// house_post_entity.dart

import 'package:equatable/equatable.dart';

class HousePostEntity extends Equatable {
  final int id;
  final String title;
  final String location;
  final double lat;
  final double lon;
  final String type;
  final String category;
  final String description;
  final List<String> images;
  final int price;
  final int beds;
  final int bathrooms;
  final int guests;
  final bool isFavorite;
  final int bedrooms;
  final List<String>? features;

  const HousePostEntity( {
    required this .features,
    required this.bedrooms,
    required this.id,
    required this.title,
    required this.location,
    required this.lat,
    required this.lon,
    required this.type,
    required this.category,
    required this.description,
    required this.images,
    required this.price,
    required this.beds,
    required this.bathrooms,
    required this.guests,
    required this.isFavorite,
  });

  factory HousePostEntity.empty() {
    return const HousePostEntity(
      id: 0,
      title: "title",
      location: "location",
      lat: 0,
      lon: 0,
      type: "type",
      category: "category",
      description: "description",
      images: [],
      price: 0,
      beds: 0,
      bathrooms: 0,
      guests: 0,
      isFavorite: false,
      bedrooms: 0, features: [],
    );
  }

  HousePostEntity copyWith({
    int? id,
    String? title,
    String? location,
    double? lat,
    double? lon,
    String? type,
    String? category,
    String? description,
    List<String>? images,
    int? price,
    int? bathrooms,
    double? square,
    int? guests,
    bool? isFavorite,
    int ?bedrooms,
    int? beds,
    List<String>? features
  }) {
    return HousePostEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      type: type ?? this.type,
      category: category ?? this.category,
      description: description ?? this.description,
      images: images ?? this.images,
      bathrooms: bathrooms ?? this.bathrooms,
      guests: guests ?? this.guests,
      isFavorite: isFavorite ?? this.isFavorite,
      price: price ?? this.price,
      beds: beds?? this.beds,
      bedrooms: bedrooms?? this.bedrooms,
        features: features ?? this.features
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        lat,
        lon,
        type,
        category,
        description,
        images,
        price,
        beds,
        bathrooms,
        guests,
        isFavorite,
    bedrooms,
    features
      ];
}
