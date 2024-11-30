class HouseDTO {
  final int beds;
  final int guests;
  final List<String> images;
  final int id;
  final String houseTitle;
  final String houseLocation;
  final double lat;
  final double lon;
  final String houseType;
  final int categoryId;
  final String category;
  final String description;
  final int price;
  final int bedrooms;
  final bool isFavorite;
  final int bathrooms;
  final int rooms;

  HouseDTO({
    required this.beds,
    required this.guests,
    required this.houseTitle,
    required this.id,
    required this.houseLocation,
    required this.isFavorite,
    required this.houseType,
    required this.category,
    required this.categoryId,
    required this.description,
    required this.images,
    required this.lon,
    required this.lat,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.rooms,
  });

  // Преобразование из JSON
  factory HouseDTO.fromJson(Map<String, dynamic> json) {
    return HouseDTO(
      beds: json['beds'] as int,
      guests: json['guests'] as int,
      houseTitle: json['houseTitle'] as String,
      id: json['id'] as int,
      houseLocation: json['houseLocation'] as String,
      isFavorite: json['isFavorite'] as bool,
      houseType: json['houseType'] as String,
      category: json['category'] as String,
      categoryId: json['categoryId'] as int,
      description: json['description'] as String,
      images: List<String>.from(json['images'] as List),
      lon: json['lon'] as double,
      lat: json['lat'] as double,
      price: json['price'] as int,
      bedrooms: json['bedrooms'] as int,
      bathrooms: json['bathrooms'] as int,
      rooms: json['rooms'] as int,
    );
  }

  // Преобразование в JSON
  Map<String, dynamic> toJson() {
    return {
      'beds': beds,
      'guests': guests,
      'houseTitle': houseTitle,
      'id': id,
      'houseLocation': houseLocation,
      'isFavorite': isFavorite,
      'houseType': houseType,
      'category': category,
      'categoryId': categoryId,
      'description': description,
      'images': images,
      'lon': lon,
      'lat': lat,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'rooms': rooms,
    };
  }
}
