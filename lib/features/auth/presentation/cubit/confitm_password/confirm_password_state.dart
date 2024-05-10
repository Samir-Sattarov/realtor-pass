part of 'confirm_password_cubit.dart';

@immutable
abstract class ConfirmPasswordState {}

class ConfirmPasswordInitial extends ConfirmPasswordState {}
class ConfirmPasswordLoading extends ConfirmPasswordState {}
class ConfirmPasswordSent extends ConfirmPasswordState {}
class ConfirmPasswordSuccess extends ConfirmPasswordState {}
class ConfirmPasswordError extends ConfirmPasswordState {
  final String message;

  ConfirmPasswordError(this.message);

}




