import '../entity/upload_photo_result_entity.dart';
import 'upload_photo_model.dart';

class UploadPhotoResultModel extends UploadPhotoResultEntity {
  const UploadPhotoResultModel({required super.photos});

  factory UploadPhotoResultModel.fromJson(List<dynamic> listJson) {
    return UploadPhotoResultModel(
      photos: listJson.map((e) => UploadPhotoModel.fromJson(e)).toList(),
    );
  }
}
