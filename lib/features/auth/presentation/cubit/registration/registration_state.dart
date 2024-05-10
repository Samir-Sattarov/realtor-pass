part of 'registration_cubit.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}
class RegistrationError extends RegistrationState {
  final String message;

  RegistrationError({required this.message});
}
class RegistrationSuccess extends RegistrationState {}
