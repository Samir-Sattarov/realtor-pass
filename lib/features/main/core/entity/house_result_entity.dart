import 'package:equatable/equatable.dart';
import 'package:realtor_pass/features/main/core/entity/house_entity.dart';

class HouseResultEntity extends Equatable {
  final List<HouseEntity> houses;

  const HouseResultEntity({required this.houses});

  factory HouseResultEntity.empty() {
    return const HouseResultEntity(houses: []);
  }

  @override
  List<Object?> get props => [
        houses.length,
      ];
}
