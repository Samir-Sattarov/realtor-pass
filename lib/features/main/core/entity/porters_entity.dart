import 'package:equatable/equatable.dart';

class PostersEntity extends Equatable {
  final List<String> images;
  const PostersEntity({required this.images});

  @override
  List<Object?> get props => [images];
}
