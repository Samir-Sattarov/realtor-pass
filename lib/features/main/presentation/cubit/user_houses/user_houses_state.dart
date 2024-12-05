part of 'user_houses_cubit.dart';

abstract class UserHousesState extends Equatable {
  const UserHousesState();
}

class UserHousesInitial extends UserHousesState {
  @override
  List<Object> get props => [];
}
class UserHousesLoading extends UserHousesState {
  @override
  List<Object> get props => [];
}
class UserHousesError extends UserHousesState {
  final String message;

  const UserHousesError(this.message);
  @override
  List<Object> get props => [];
}
class UserHousesLoaded extends UserHousesState {
  final List <HouseEntity> resultEntity;

  const UserHousesLoaded({required this.resultEntity});
  @override
  List<Object> get props => [];
}
