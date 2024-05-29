part of 'houses_cubit.dart';

@immutable
abstract class HousesState {}

class HousesInitial extends HousesState {}

class HousesLoading extends HousesState {}

class HousesLoaded extends HousesState {
  final List<HouseEntity> houses;

  HousesLoaded(this.houses);
}

class HousesError extends HousesState {
  final String message;

  HousesError(this.message);
}
