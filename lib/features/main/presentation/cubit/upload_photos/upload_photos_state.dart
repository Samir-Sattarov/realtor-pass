part of 'upload_photos_cubit.dart';

@immutable
abstract class UploadPhotosState {}

class UploadPhotosInitial extends UploadPhotosState {}
class UploadPhotosLoading extends UploadPhotosState {}
class UploadPhotosError extends UploadPhotosState {
  final String messsage;

  UploadPhotosError(this.messsage);
}
class UploadPhotosSuccess extends UploadPhotosState {
  final UploadPhotoResultEntity result;

  UploadPhotosSuccess(this.result);
}
