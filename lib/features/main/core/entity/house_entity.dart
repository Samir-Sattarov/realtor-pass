// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class HouseEntity extends Equatable {
  final List<String> images;
  final int id;
  final String houseTitle;
  final String houseLocation;
  final double lat;
  final double lon;
  final String houseType;
  final int categoryId;
  final String category;
  final String description;
  final int price;
  final int square;
  bool isFavorite;
  final int bathroom;
  final int rooms;

  HouseEntity(
   {
     required this.houseTitle,
    required this.id,
    required this.houseLocation,
    required this.isFavorite,
    required this.houseType,
    required this.category,
    required this.categoryId,
    required this.description,
    required this.images,
    required this.lon,
    required this.lat,
    required this.price,
    required this.square,
    required this.bathroom,
    required this.rooms,
  });

  @override
  List<Object?> get props => [
        id,
        houseTitle,
        houseLocation,
        houseType,
        category,
        categoryId,
        description,
        images,
        price,
        square,
        bathroom,
        rooms,
      ];
}
