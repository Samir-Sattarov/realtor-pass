import 'package:equatable/equatable.dart';

class QuestionsEntity extends Equatable{
  final String name;
  final String description;

  const QuestionsEntity({required this.name, required this.description});

  @override
  List<Object?> get props => [
    name,
    description,
  ];
}