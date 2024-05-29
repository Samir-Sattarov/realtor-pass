import 'package:equatable/equatable.dart';
import 'package:realtor_pass/features/main/core/entity/questions_entity.dart';

class QuestionsResultEntity extends Equatable {
  final List<QuestionsEntity> questions;

  const QuestionsResultEntity({required this.questions});

  @override
  List<Object?> get props => [questions.length];
}
