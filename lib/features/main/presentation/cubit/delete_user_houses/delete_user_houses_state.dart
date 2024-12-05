part of 'delete_user_houses_cubit.dart';

abstract class DeleteUserHousesState extends Equatable {
  const DeleteUserHousesState();
}

class DeleteUserHousesInitial extends DeleteUserHousesState {
  @override
  List<Object> get props => [];
}
class DeleteUserHousesLoading extends DeleteUserHousesState {
  @override
  List<Object> get props => [];
}
class DeleteUserHousesError extends DeleteUserHousesState {
  final String message;

  const DeleteUserHousesError(this.message);
  @override
  List<Object> get props => [];
}
class DeleteUserHousesDeleted extends DeleteUserHousesState {
  final int id ;

  const DeleteUserHousesDeleted(this.id);
  @override
  List<Object> get props => [];
}
