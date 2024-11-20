import 'package:equatable/equatable.dart';

class HouseSellingTypeEntity extends Equatable {
  final int id;
  final String title;
  final String url;

  const HouseSellingTypeEntity({required this.title, required this.url, required this.id});

  @override
  List<Object?> get props => [title, url];
}
