import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../entity/house_post_entity.dart';
import '../entity/upload_photo_result_entity.dart';
import '../repository/main_repository.dart';

class PostHouseUsecase extends UseCase<void, PostHouseUsecaseParams> {
  final MainRepository mainRepository;

  PostHouseUsecase(this.mainRepository);

  @override
  Future<Either<AppError, void>> call(PostHouseUsecaseParams params) {
    return mainRepository.postHouse(params.entity);
  }
}

class PostHouseUsecaseParams {
  final HousePostEntity entity;

  PostHouseUsecaseParams(this.entity);
}


class UploadImagesUseCase extends UseCase<UploadPhotoResultEntity, UploadImagesParams> {
  final MainRepository repository;

  UploadImagesUseCase(this.repository);

  @override
  Future<Either<AppError, UploadPhotoResultEntity>> call(UploadImagesParams params) {
    return repository.uploadImages(params.images);
  }
}

class UploadImagesParams {
  final List<File> images;

  UploadImagesParams(this.images);
}


