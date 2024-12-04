import '../entity/upload_photo_entity.dart';

class UploadPhotoModel extends UploadPhotoEntity {

  const UploadPhotoModel({
    required super.id,
    required super.imageUrl,
  });

  factory UploadPhotoModel.fromJson(Map<String, dynamic> json) {
    return UploadPhotoModel(
      id: json['id'],
      imageUrl: json['url'],
    );
  }
}
