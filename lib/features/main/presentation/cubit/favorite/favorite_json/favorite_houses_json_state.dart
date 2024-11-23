part of 'favorite_houses_json_cubit.dart';


abstract class FavoriteHousesJsonState extends Equatable {
  const FavoriteHousesJsonState();
}

class FavoriteHousesJsonInitial extends FavoriteHousesJsonState {
  @override
  List<Object> get props => [];
}
class FavoriteHousesJsonLoading extends FavoriteHousesJsonState {
  @override
  List<Object> get props => [];
}
class FavoriteHousesJsonError extends FavoriteHousesJsonState {
  @override
  List<Object> get props => [];
}
class FavoriteHousesJsonLoaded extends FavoriteHousesJsonState {
  @override
  List<Object> get props => [];
}