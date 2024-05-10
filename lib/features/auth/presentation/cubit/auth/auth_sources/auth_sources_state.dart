part of 'auth_sources_cubit.dart';

@immutable
sealed class AuthSourcesState {}

final class AuthSourcesInitial extends AuthSourcesState {}

final class AuthSourcesLoading extends AuthSourcesState {}

final class AuthSourcesError extends AuthSourcesState {
  final String message;

  AuthSourcesError(this.message);
}

final class AuthSourcesSuccess extends AuthSourcesState {
  final String link;

  AuthSourcesSuccess(this.link);
}
