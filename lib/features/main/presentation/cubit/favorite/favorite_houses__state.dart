part of 'favorite_houses__cubit.dart';

abstract class FavoriteHousesState extends Equatable {
  const FavoriteHousesState();
}

class FavoriteHousesInitial extends FavoriteHousesState {
  @override
  List<Object> get props => [];
}

class FavoriteHousesLoading extends FavoriteHousesState {
  @override
  List<Object> get props => [];
}

class FavoriteHousesUpdated extends FavoriteHousesState {
  final int publicationsId;

  const FavoriteHousesUpdated({required this.publicationsId});
  @override
  List<Object> get props => [];
}

class FavoriteHousesError extends FavoriteHousesState {
  final String message;

  FavoriteHousesError(this.message);
  @override
  List<Object> get props => [];
}

class FavoriteHousesLoaded extends FavoriteHousesState {
  final HouseResultEntity resultEntity;

  const FavoriteHousesLoaded(this.resultEntity);
  @override
  List<Object> get props => [];
}
