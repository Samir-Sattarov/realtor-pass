import 'package:equatable/equatable.dart';

class ProfitableTermsEntity extends Equatable {
  final String title;
  final String description;

  const ProfitableTermsEntity(
      {required this.title, required this.description});

  @override
  List<Object?> get props => [
    title,
    description,
  ];
}