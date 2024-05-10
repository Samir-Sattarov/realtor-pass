part of 'edit_user_cubit.dart';

@immutable
abstract class EditUserState {}

class EditUserInitial extends EditUserState {}
class EditUserLoading extends EditUserState {}
class EditUserError extends EditUserState {
  final String message;

  EditUserError(this.message);
}
class EditUserCodeSended extends EditUserState {}
class EditUserSuccess extends EditUserState {}