import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app_core/utils/storage_service.dart';
import '../../../core/datasources/house_dto.dart';
import '../../../core/entity/house_entity.dart';
import '../../../core/models/house_mapper.dart';
import 'favorite_state.dart';

class FavoriteHousesCubit extends Cubit<FavoriteHousesState> {
  final StorageService storage;

  FavoriteHousesCubit(this.storage) : super(const FavoriteHousesInitial()) {
    load();
  }

  static List<HouseEntity> _listFavoriteHouses = [];

  List<HouseEntity> get listFavoriteHouses => _listFavoriteHouses;

  static const String _favoriteHousesKey = 'favorite_houses';

  Future<void> load() async {
    emit(const FavoriteHousesLoading());
    _listFavoriteHouses.clear();

    final listFavHousesDataJson =
        await storage.get(key: _favoriteHousesKey) ?? [];

    _listFavoriteHouses = List.from(listFavHousesDataJson)
        .map((e) {
      try {
        final Map<String, dynamic> data = Map<String, dynamic>.from(e);
        return HouseMapper.fromDTO(HouseDTO.fromJson(data));
      } catch (error) {
        print("Error processing element: $error");
        return null;
      }
    })
        .whereType<HouseEntity>()
        .toList();

    emit(FavoriteHousesLoaded(_listFavoriteHouses));
  }

  Future<void> addFavorite(HouseEntity house) async {
    if (!_listFavoriteHouses.any((item) => item.id == house.id)) {
      _listFavoriteHouses.add(house);

      await storage.save(
        key: _favoriteHousesKey,
        value: _listFavoriteHouses
            .map((e) => HouseMapper.toDTO(e).toJson())
            .toList(),
      );

      emit(FavoriteHousesChanged(_listFavoriteHouses));
    }
  }

  Future<void> removeFavorite(int houseId) async {
    _listFavoriteHouses.removeWhere((item) => item.id == houseId);

    await storage.save(
      key: _favoriteHousesKey,
      value: _listFavoriteHouses
          .map((e) => HouseMapper.toDTO(e).toJson())
          .toList(),
    );

    emit(FavoriteHousesChanged(_listFavoriteHouses));
  }

  bool isFavorite(int houseId) {
    return _listFavoriteHouses.any((item) => item.id == houseId);
  }

  Future<void> deleteAllFavorites() async {
    _listFavoriteHouses.clear();

    await storage.delete(key: _favoriteHousesKey);

    emit(FavoriteHousesChanged(_listFavoriteHouses));
  }
}
