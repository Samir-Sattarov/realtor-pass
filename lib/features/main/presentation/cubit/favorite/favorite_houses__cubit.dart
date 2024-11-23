import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app_core/app_core_library.dart';
import '../../../core/entity/house_result_entity.dart';
import '../../../core/usecases/houses_usecase.dart';
import 'favorite_json/favorite_houses_json_cubit.dart';

part 'favorite_houses__state.dart';

class FavoriteHousesCubit extends Cubit<FavoriteHousesState> {
  final GetFavoriteHousesUsecase getFavoriteHousesUsecase;
  final DeleteHousesFromFavoriteUsecase deleteHousesFromFavoriteUsecase;
  final DeleteAllHousesFromFavoriteUsecase deleteAllHousesFromFavoriteUsecase;
  final SaveHousesToFavoriteUsecase saveCarToFavoriteUsecase;
  final FavoriteHousesJsonCubit favoriteCarsJsonCubit;

  FavoriteHousesCubit(
      this.saveCarToFavoriteUsecase,
      this.favoriteCarsJsonCubit,
      this.getFavoriteHousesUsecase,
      this.deleteHousesFromFavoriteUsecase,
      this.deleteAllHousesFromFavoriteUsecase)
      : super(FavoriteHousesInitial());

  save(int publicationsId) async {
    emit(FavoriteHousesLoading());
    final response = await saveCarToFavoriteUsecase.call(
      FavoriteParams(publicationsID: publicationsId),
    );

    response.fold(
      (l) => emit(FavoriteHousesError(l.errorMessage)),
      (r) {
        favoriteCarsJsonCubit.load();

        emit(FavoriteHousesUpdated(publicationsId: publicationsId));
      },
    );
  }

  load() async {
    emit(FavoriteHousesLoading());
    final response = await getFavoriteHousesUsecase.call(
      NoParams(),
    );

    response.fold(
      (l) => emit(FavoriteHousesError(l.errorMessage)),
      (r) {
        favoriteCarsJsonCubit.load();
        emit(FavoriteHousesLoaded(r));
      },
    );
  }

  remove(int publicationsId) async {
    emit(FavoriteHousesLoading());
    final response = await deleteHousesFromFavoriteUsecase.call(
      FavoriteParams(publicationsID: publicationsId),
    );

    response.fold(
      (l) => emit(FavoriteHousesError(l.errorMessage)),
      (r) {
        favoriteCarsJsonCubit.load();

        emit(FavoriteHousesUpdated(publicationsId: publicationsId));
      },
    );
  }

  deleteAll() async {
    await deleteAllHousesFromFavoriteUsecase.call(NoParams());
  }
}
