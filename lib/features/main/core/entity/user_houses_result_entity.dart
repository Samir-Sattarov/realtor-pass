import 'package:equatable/equatable.dart';
import 'package:realtor_pass/features/main/core/entity/house_entity.dart';

class UserHousesResultEntity extends Equatable {
  final List<HouseEntity> houses;

  const UserHousesResultEntity({required this.houses});

  factory UserHousesResultEntity.empty() {
    return const UserHousesResultEntity(houses: []);
  }

  @override
  List<Object?> get props => [
    houses
  ];
}
