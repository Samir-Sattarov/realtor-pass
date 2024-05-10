part of 'forgot_password_cubit.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}
class ForgotPasswordILoading extends ForgotPasswordState {}
class ForgotPasswordError extends ForgotPasswordState {
  final String message;

  ForgotPasswordError(this.message);

}
class ForgotPasswordSuccess extends ForgotPasswordState {}
class ForgotPasswordSent extends ForgotPasswordState {}




