import 'package:equatable/equatable.dart';

import 'house_type_entity.dart';


class HouseTypeResultEntity extends Equatable {
  final List<HouseTypeEntity> houses;

  const HouseTypeResultEntity({required this.houses});

  @override
  // TODO: implement props
  List<Object?> get props => [houses.length];
}
