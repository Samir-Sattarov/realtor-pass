import 'package:equatable/equatable.dart';

import '../../../core/entity/house_entity.dart';

abstract class FavoriteHousesState extends Equatable {
  const FavoriteHousesState();

  @override
  List<Object?> get props => [];
}

class FavoriteHousesInitial extends FavoriteHousesState {
  const FavoriteHousesInitial();

  @override
  List<Object?> get props => [];
}

class FavoriteHousesLoading extends FavoriteHousesState {
  const FavoriteHousesLoading();

  @override
  List<Object?> get props => [];
}

class FavoriteHousesLoaded extends FavoriteHousesState {
  final List<HouseEntity> favoriteHouses;

  const FavoriteHousesLoaded(this.favoriteHouses);

  @override
  List<Object?> get props => [favoriteHouses];
}

class FavoriteHousesChanged extends FavoriteHousesState {
  final List<HouseEntity> favoriteHouses;

  const FavoriteHousesChanged(this.favoriteHouses);

  @override
  List<Object?> get props => [favoriteHouses];
}

class FavoriteHousesError extends FavoriteHousesState {
  final String message;

  const FavoriteHousesError(this.message);

  @override
  List<Object?> get props => [message];
}