import '../entity/porters_entity.dart';

class PostersModel extends PostersEntity {
  const PostersModel({required super.images});

  factory PostersModel.fromJson(PostersEntity entity) {
    return PostersModel(images: entity.images);
  }
  factory PostersModel.toJson(Map<String, dynamic> json) {
    return PostersModel(
      images: List<String>.from(
        List<Map<String, dynamic>>.from(
          json["data"]
              .map((itemJson) => itemJson["images"])
              .toList(),
        ),
      ),
    );
  }
}
