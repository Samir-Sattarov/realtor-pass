import 'package:equatable/equatable.dart';

class FewStepsEntity extends Equatable {
  final String title;

  const FewStepsEntity({required this.title});

  @override
  List<Object?> get props => [title];
}
