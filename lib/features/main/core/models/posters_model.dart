import '../entity/porters_entity.dart';

class PostersModel extends PostersEntity {
  const PostersModel({required super.images});

  factory PostersModel.fromJson(Map<String, dynamic> json) {
    return PostersModel(
      images: List<String>.from(
        json["data"].map<String>((itemJson) => itemJson["url"].toString()).toList(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'images': images,
    };
  }
}
