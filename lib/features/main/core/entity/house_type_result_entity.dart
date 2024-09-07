import 'package:equatable/equatable.dart';

import 'house_type_entity.dart';


class HouseTypeResultEntity extends Equatable {
  final List<HouseTypeEntity> housesType;

  const HouseTypeResultEntity({required this.housesType});

  @override
  List<Object?> get props => [housesType.length];
}
