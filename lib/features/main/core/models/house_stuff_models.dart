import '../entity/house_stuff_entity.dart';

class HouseStuffModel extends HouseStuffEntity {
  const HouseStuffModel(
      {required super.title,
      required super.id,
      required super.description,
      required super.image});
  factory HouseStuffModel.fromEntity(HouseStuffEntity entity) {
    return HouseStuffModel(
        title: entity.title,
        id: entity.id,
        description: entity.description,
        image: entity.image);
  }
  factory HouseStuffModel.fromJson(Map<String, dynamic> json) {
    return HouseStuffModel(
      title: json['title'],
      id: json['id'],
      description: json['description'],
      image: json['image'],
    );
  }
}
