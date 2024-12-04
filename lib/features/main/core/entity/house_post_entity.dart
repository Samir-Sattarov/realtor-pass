import 'package:equatable/equatable.dart';

import 'upload_photo_result_entity.dart';

class HousePostEntity extends Equatable {
  final String title;
  final String location;
  final double lat;
  final double lon;
  final int type;
  final int category;
  final String description;
  final UploadPhotoResultEntity images;
  final int price;
  final int beds;
  final int bathrooms;
  final int guests;
  final bool isFavorite;
  final int bedrooms;
  final String address;
  final String phone;
  final String email;
  final List<int> featuresId;
  final int ownerId;

  const HousePostEntity(
      {
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
      required this.bedrooms,
      required this.address,
      required this.phone,
      required this.email,
      required this.featuresId,
      required this.ownerId});

  factory HousePostEntity.empty() {
    return HousePostEntity(
      ownerId: 0,

      title: "",
      location: "",
      lat: 0.0,
      lon: 0.0,
      type: 0,
      category: 0,
      description: "",
      images: UploadPhotoResultEntity.empty(),
      price: 0,
      beds: 0,
      bathrooms: 0,
      guests: 0,
      isFavorite: false,
      bedrooms: 0,
      address: "",
      phone: "",
      email: "",
      featuresId: const [],
    );
  }

  HousePostEntity copyWith({

    String? title,
    String? location,
    double? lat,
    double? lon,
    int? type,
    int? category,
    String? description,
    UploadPhotoResultEntity? images,
    int? price,
    int? bathrooms,
    int? guests,
    bool? isFavorite,
    int? bedrooms,
    int? beds,
    String? address,
    String? phone,
    String? email,
    List<int>? featuresId,
    int? ownerId,
  }) {
    return HousePostEntity(

        title: title ?? this.title,
        location: location ?? this.location,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        type: type ?? this.type,
        category: category ?? this.category,
        description: description ?? this.description,
        images: images ?? this.images,
        price: price ?? this.price,
        beds: beds ?? this.beds,
        bathrooms: bathrooms ?? this.bathrooms,
        guests: guests ?? this.guests,
        isFavorite: isFavorite ?? this.isFavorite,
        bedrooms: bedrooms ?? this.bedrooms,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        featuresId: featuresId ?? this.featuresId,
        ownerId: ownerId ?? this.ownerId);
  }

  @override
  List<Object?> get props => [
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
        address,
        phone,
        email,
        featuresId,
      ];
}
