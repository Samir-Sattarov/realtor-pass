import 'package:equatable/equatable.dart';

import 'house_stuff_entity.dart';

class HouseStuffResultEntity extends Equatable {
  final List<HouseStuffEntity> houseStuff;

  const HouseStuffResultEntity({required this.houseStuff});

  factory HouseStuffResultEntity.empty() {
    return const HouseStuffResultEntity(houseStuff: []);
  }

  @override
  List<Object?> get props => [
    houseStuff.length,
  ];
}
