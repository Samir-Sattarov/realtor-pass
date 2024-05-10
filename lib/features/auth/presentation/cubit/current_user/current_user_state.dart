part of 'current_user_cubit.dart';

abstract class CurrentUserState {}

class CurrentUserInitial extends CurrentUserState {}
class CurrentUserLoading extends CurrentUserState {}
class CurrentUserError extends CurrentUserState {
  final String message;

  CurrentUserError(this.message);
}
class CurrentUserLoaded extends CurrentUserState {
  final UserEntity user;

  CurrentUserLoaded(this.user);
}
