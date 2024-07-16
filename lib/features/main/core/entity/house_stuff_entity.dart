import 'package:equatable/equatable.dart';

class HouseStuffEntity extends Equatable {
  final String title;
  final int id;
  final String description;
  final String image;

  const HouseStuffEntity(
      {required this.title,
      required this.id,
      required this.description,
      required this.image});

  @override
  List<Object?> get props => [
    title,
    id,
    description,
    image
  ];
}
