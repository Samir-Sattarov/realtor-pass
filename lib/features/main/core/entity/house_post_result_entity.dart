import 'package:equatable/equatable.dart';
import 'house_post_entity.dart';

class HousePostResultEntity extends Equatable {
  final List<HousePostEntity> posts;

  const HousePostResultEntity({required this.posts});

  factory HousePostResultEntity.empty() {
    return const HousePostResultEntity(posts: []);
  }

  @override
  List<Object?> get props => [
    posts.length,
  ];
}
