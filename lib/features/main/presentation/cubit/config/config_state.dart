part of 'config_cubit.dart';

@immutable
abstract class ConfigState  extends Equatable{}

class ConfigInitial extends ConfigState {
  @override
  List<Object?> get props => [];
}
class ConfigLoading extends ConfigState {
  @override
  List<Object?> get props => [];
}
class ConfigError extends ConfigState {
  final String message;

  ConfigError(this.message);

  @override
  List<Object?> get props => [
    message
  ];
}
class ConfigLoaded extends ConfigState {
  final ConfigEntity entity;

  ConfigLoaded(this.entity);
  @override
  List<Object?> get props => [
    entity.priceMin,
    entity.priceMax,
    entity.floorsMin,
    entity.floorsMax,
    entity.redirectLink,
    entity.squareMin,
    entity.squareMax,
    entity.roomsMin,
    entity.roomsMax,
    entity.windowsMin,
    entity.windowsMax,
  ];
}
