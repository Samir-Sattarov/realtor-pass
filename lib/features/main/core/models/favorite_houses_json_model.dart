
import '../entity/favorite_houses_json_entity.dart';

class FavoriteHousesJsonModel extends FavoriteHousesJsonEntity {
  const FavoriteHousesJsonModel({required super.favoriteHousesId});

  factory FavoriteHousesJsonModel.fromListIds(List<int> favoriteHousesIds) {
    final Map<int, dynamic> data = {};

    for (final id in favoriteHousesIds) {
      if (!data.containsKey(id)) {
        data[id] = 1;
      }
    }

    return FavoriteHousesJsonModel(
      favoriteHousesId: data,
    );
  }
}
