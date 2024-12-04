import 'package:equatable/equatable.dart';

import 'upload_photo_entity.dart';

class UploadPhotoResultEntity extends Equatable{
  final List<UploadPhotoEntity> photos;

  const UploadPhotoResultEntity({required this.photos});

  factory UploadPhotoResultEntity.empty() {

    return UploadPhotoResultEntity(photos: const [],);
  }

  @override
  List<Object?> get props => [
    photos,
  ];
}