import 'package:equatable/equatable.dart';

class ChipEntity extends Equatable {
  final int id;
  final String title;
  final String image;

  const ChipEntity( {required this.id, required this.image,required this.title});

  @override
  List<Object?> get props => [
    id,
  ];
}
