part of 'profitable_terms_cubit.dart';

@immutable
abstract class ProfitableTermsState extends Equatable {}

class ProfitableTermsInitial extends ProfitableTermsState {
  @override
  List<Object?> get props => [];
}

class ProfitableTermsLoading extends ProfitableTermsState {
  @override
  List<Object?> get props => [];
}

class ProfitableTermsError extends ProfitableTermsState {
  final String message;

  ProfitableTermsError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfitableTermsLoaded extends ProfitableTermsState {
  final ProfitableTermsResultEntity entity;

  ProfitableTermsLoaded(this.entity);
  @override
  List<Object?> get props => [entity.terms.length];
}
