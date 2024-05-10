part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
class AuthLoginSuccess extends AuthState {}
class AuthLogOutSuccess extends AuthState {}
class AuthRegisterSuccess extends AuthState {}
