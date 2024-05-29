import 'package:equatable/equatable.dart';

class HouseTypeEntity extends Equatable{
  final int id ;
  final String title;

  const HouseTypeEntity({required this.id, required this.title});

  @override

  List<Object?> get props => [
    id,
    title
  ];



}