part of 'house_type_cubit.dart';

@immutable
abstract class HouseTypeState {}

class HouseTypeInitial extends HouseTypeState {}
final class HouseTypeLoading extends HouseTypeState {}

final class HouseTypeError extends HouseTypeState {
  final String message;

  HouseTypeError({required this.message});
}

final class HouseTypeLoaded extends HouseTypeState {
  final HouseTypeResultEntity results;

  HouseTypeLoaded( this.results);
}
