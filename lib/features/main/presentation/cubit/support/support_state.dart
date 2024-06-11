part of 'support_cubit.dart';

@immutable
abstract class SupportState {}

class SupportInitial extends SupportState {}
class SupportLoading extends SupportState {}

class SupportError extends SupportState {
  final String message;

  SupportError(this.message);
}

class SupportSend extends SupportState {}
