import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/entity/upload_photo_result_entity.dart';
import '../../../core/usecases/post_house_usecase.dart';

part 'upload_photos_state.dart';

class UploadPhotosCubit extends Cubit<UploadPhotosState> {
  final UploadImagesUseCase uploadImagesUseCase;
  UploadPhotosCubit(this.uploadImagesUseCase) : super(UploadPhotosInitial());

  upload(List<File> images) async {
    emit(UploadPhotosLoading());
    final response = await uploadImagesUseCase.call(UploadImagesParams(images));
    response.fold(
      (l) => emit(UploadPhotosError(l.errorMessage)),
      (r) => emit(UploadPhotosSuccess(r)),
    );
  }
}
