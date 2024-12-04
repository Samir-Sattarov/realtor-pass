import 'package:equatable/equatable.dart';

class UploadPhotoEntity extends Equatable{
  final int id;
  final String imageUrl;

  const UploadPhotoEntity({required this.id, required this.imageUrl});

  @override
  List<Object?> get props => [
    id, imageUrl,

  ];
}