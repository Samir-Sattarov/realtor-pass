import '../entity/house_post_entity.dart';

class HousePostModel extends HousePostEntity {
  const HousePostModel({
    required super.ownerId,
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
    required super.isFavorite,
    required super.bedrooms,
    required super.address,
    required super.phone,
    required super.email,
    required super.featuresId,
  });

  factory HousePostModel.fromEntity(HousePostEntity entity) {
    return HousePostModel(
      ownerId: entity.ownerId,
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
      isFavorite: entity.isFavorite,
      bedrooms: entity.bedrooms,
      address: entity.address,
      phone: entity.phone,
      email: entity.email,
      featuresId: entity.featuresId,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'email': email,
      'phone': phone,
      'categoryId': category,
      'sellingTypeId': type,
      'ownerId': ownerId,
      'rooms': {
        'guests': guests,
        'bedrooms': bedrooms,
        'beds': beds,
        'bathrooms': bathrooms,
      },
      'address': {
        'exactAddress': address,
        'coords': {'lat': lat, 'lng': lon},
      },
      'featuresIds': featuresId,
      'imageIds': images.photos.map((e) => e.id).toList(),
      'status': "PUBLISHED"

    };
  }
}

