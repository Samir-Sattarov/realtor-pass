part of 'questions_cubit.dart';

@immutable
abstract class QuestionsState extends Equatable {
  const QuestionsState();
}

class QuestionsInitial extends QuestionsState {
  @override
  List<Object?> get props => [];
}

class QuestionsLoading extends QuestionsState {
  @override
  List<Object?> get props => [];
}

class QuestionsError extends QuestionsState {
  final String message;

  const QuestionsError({required this.message});
  @override
  List<Object?> get props => [];
}

final class QuestionsLoaded extends QuestionsState {
  final QuestionsResultEntity data;

  const QuestionsLoaded({required this.data});
  @override
  List<Object> get props => [data.questions.length];
}
