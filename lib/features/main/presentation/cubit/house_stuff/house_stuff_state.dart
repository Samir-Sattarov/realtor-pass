part of 'house_stuff_cubit.dart';

@immutable
abstract class HouseStuffState extends Equatable {}

class HouseStuffInitial extends HouseStuffState {
  @override
  List<Object?> get props => [];
}
class HouseStuffLoading extends HouseStuffState {
  @override
  List<Object?> get props => [];
}
class HouseStuffError extends HouseStuffState {
  final String message;

  HouseStuffError(this.message);
  @override
  List<Object?> get props => [];
}
class HouseStuffLoaded extends HouseStuffState {
  final List<HouseStuffEntity> houses;

  HouseStuffLoaded({required this.houses});

  @override
  List<Object?> get props => [];
}