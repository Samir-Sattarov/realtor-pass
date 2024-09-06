import '../entity/house_stuff_entity.dart';

class HouseStuffModel extends HouseStuffEntity {
  const HouseStuffModel({
    required super.title,
    required super.id,
    required super.description,
    required super.image,
  });

  factory HouseStuffModel.fromEntity(HouseStuffEntity entity) {
    return HouseStuffModel(
        title: entity.title,
        id: entity.id,
        description: entity.description,
        image: entity.image);
  }

  factory HouseStuffModel.fromJson(Map<String, dynamic> json,
      {required String locale}) {
    final description = json['${locale}Title'];
    return HouseStuffModel(
      title: json['${locale}Title'],
      id: json['id'],
      description: "",
      image: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'description': description,
      'image': image,
    };
  }
}
