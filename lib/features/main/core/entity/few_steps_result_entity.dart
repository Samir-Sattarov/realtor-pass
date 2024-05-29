import 'package:equatable/equatable.dart';

import 'few_steps_entity.dart';

class FewStepsResultEntity extends Equatable {
  final List<FewStepsEntity> steps;

  const FewStepsResultEntity({required this.steps});

  factory FewStepsResultEntity.empty() {
    return const FewStepsResultEntity(steps: []);
  }
  @override
  List<Object?> get props => [steps.length];
}
