import '../entity/house_selling_type_entity.dart';

class HouseSellingTypeModel extends HouseSellingTypeEntity {
  const HouseSellingTypeModel({required super.title, required super.url, required super.id});

  factory HouseSellingTypeModel.fromEntity(HouseSellingTypeEntity entity) {
    return HouseSellingTypeModel(title: entity.title, url: entity.url, id: entity.id);
  }
  factory HouseSellingTypeModel.fromJson(Map<String, dynamic> json, {required String locale}) {
    String titleKey = '${locale}Title'; // Формируем ключ на основе языка
    return HouseSellingTypeModel(
      id: json['id'] as int,
      title: json[titleKey] as String,
      url: json['url'] as String,
    );
  }


  Map<String, dynamic> toJson(){
    return {
      "title":title,
      "url":url,
      "id":id
    };
  }
}
