import 'package:equatable/equatable.dart';

import 'house_result_entity.dart';


class FavoriteHousesJsonEntity extends Equatable {
  final Map<int, dynamic> favoriteHousesId;

  const FavoriteHousesJsonEntity({
    required this.favoriteHousesId,
  });

  factory FavoriteHousesJsonEntity.fromCarsEntity(HouseResultEntity entity) {
    final data = <int, dynamic>{};

    for (final houses in entity.houses) {
      data[houses.id] = 1;
    }

    return FavoriteHousesJsonEntity(
      favoriteHousesId: data,
    );
  }

  @override
  List<Object?> get props => [favoriteHousesId.keys.length];
}
