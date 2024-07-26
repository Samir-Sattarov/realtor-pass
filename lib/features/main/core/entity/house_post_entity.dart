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
  final int square;
  final int bathrooms;
  final int rooms;
  final bool isFavorite;

  const HousePostEntity({
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
    required this.square,
    required this.bathrooms,
    required this.rooms,
    required this.isFavorite,
  });

  factory HousePostEntity.empty() {
    return const HousePostEntity(
      id: 3,
      title: "title",
      location: "location",
      lat: 44,
      lon: 44,
      type: "type",
      category: "category",
      description: "description",
      images: [],
      price: 45,
      square: 44,
      bathrooms: 4,
      rooms: 4,
      isFavorite: false,
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
    double? price,
    int? bathrooms,
    double? square,
    int? rooms,
    bool? isFavorite,
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
      rooms: rooms ?? this.rooms,
      isFavorite: isFavorite ?? this.isFavorite,
      price: 4,
      square: 4,
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
        square,
        bathrooms,
        rooms,
        isFavorite,
      ];
}
