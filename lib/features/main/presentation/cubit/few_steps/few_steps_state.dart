part of 'few_steps_cubit.dart';

@immutable
abstract class FewStepsState extends Equatable {}

class FewStepsInitial extends FewStepsState {
  @override
  List<Object?> get props => [];
}

class FewStepsLoading extends FewStepsState {
  @override
  List<Object?> get props => [];
}

class FewStepsError extends FewStepsState {
  final String message;

  FewStepsError(this.message);
  @override
  List<Object?> get props => [];
}

class FewStepsLoaded extends FewStepsState {
  final FewStepsResultEntity fewStepsResultEntity;

  FewStepsLoaded(this.fewStepsResultEntity);
  @override
  List<Object?> get props => [fewStepsResultEntity.steps.length];
}
