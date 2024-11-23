import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../app_core/app_core_library.dart';
import '../../../../core/usecases/houses_usecase.dart';

part 'favorite_houses_json_state.dart';

class FavoriteHousesJsonCubit extends Cubit<FavoriteHousesJsonState> {
  final GetFavoriteHouseJsonUsecase getFavoriteCarsJsonUsecase;

  FavoriteHousesJsonCubit(this.getFavoriteCarsJsonUsecase)
      : super(FavoriteHousesJsonInitial());

  load() async {
    emit(FavoriteHousesJsonLoading());
    final response = await getFavoriteCarsJsonUsecase.call(NoParams());

    response.fold(
      (l) => emit(FavoriteHousesJsonError()),
      (r) => emit(FavoriteHousesJsonLoaded()),
    );
  }
}
