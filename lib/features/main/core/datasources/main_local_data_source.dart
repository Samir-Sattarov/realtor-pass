import 'package:hive/hive.dart';
import '../../../../app_core/app_core_library.dart';
import '../models/favorite_houses_json_model.dart';

abstract class MainLocalDataSource {
  Future<FavoriteHousesJsonModel> getFavoriteCars();
  Future<void> saveFavoriteHouses(int publicationsId);

  Future<void> deleteFavoriteHouse(int publicationsId);

  Future<void> deleteAllFavoriteCars();
}

class MainLocalDataSourceImpl extends MainLocalDataSource {
  @override
  Future<FavoriteHousesJsonModel> getFavoriteCars() async {
    final box = await Hive.openBox<int>(StorageKeys.kFavoriteHousesId);
    final List<int> listIds = box.values.toList();

    final model =
    FavoriteHousesJsonModel.fromListIds(listIds.isEmpty ? [] : listIds);
    return model;
  }

  @override
  Future<void> saveFavoriteHouses(int publicationsId) async {
    final box = await Hive.openBox<int>(StorageKeys.kFavoriteHousesId);

    await box.add(publicationsId);
  }

  @override
  Future<void> deleteAllFavoriteCars() async {
    final box = await Hive.openBox<int>(StorageKeys.kFavoriteHousesId);

    await box.clear();
  }

  @override
  Future<void> deleteFavoriteHouse(int publicationsId) async {
    final box = await Hive.openBox<int>(StorageKeys.kFavoriteHousesId);

    final listData = box.values.toList();

    listData.remove(publicationsId);

    await box.clear();
    await box.addAll(listData);
  }
}
