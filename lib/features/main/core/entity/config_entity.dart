import 'package:equatable/equatable.dart';

class ConfigEntity extends Equatable {
  final String redirectLink;
  final int priceMin;
  final int priceMax;
  final int squareMin;
  final int squareMax;
  final int roomsMin;
  final int roomsMax;
  final int floorsMin;
  final int floorsMax;
  final int windowsMin;
  final int windowsMax;

  const ConfigEntity({
    required this.redirectLink,
    required this.priceMin,
    required this.priceMax,
    required this.floorsMin,
    required this.floorsMax,
    required this.squareMin,
    required this.squareMax,
    required this.roomsMin,
    required this.roomsMax,
    required this.windowsMin,
    required this.windowsMax,
  });

  @override
  List<Object?> get props => [
    redirectLink,
    priceMin,
    priceMax,
    floorsMin,
    floorsMax,
    squareMin,
    squareMax,
    roomsMin,
    roomsMax,
    windowsMin,
    windowsMax,
  ];
}
