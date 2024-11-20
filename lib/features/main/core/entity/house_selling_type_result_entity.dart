import 'package:equatable/equatable.dart';
import 'house_selling_type_entity.dart';

class HouseSellingTypeResultEntity extends Equatable {
  final List<HouseSellingTypeEntity> houseSellingType;

  const HouseSellingTypeResultEntity({required this.houseSellingType});

  factory HouseSellingTypeResultEntity.empty() {
    return const HouseSellingTypeResultEntity(houseSellingType: []);
  }

  @override
  List<Object?> get props => [
    houseSellingType.length,
  ];
}
