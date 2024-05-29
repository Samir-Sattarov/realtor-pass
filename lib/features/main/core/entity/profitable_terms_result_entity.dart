import 'package:equatable/equatable.dart';
import 'package:realtor_pass/features/main/core/entity/profitable_terms_entity.dart';


class ProfitableTermsResultEntity extends Equatable {
  final List<ProfitableTermsEntity> terms;

  const ProfitableTermsResultEntity({required this.terms});


  factory ProfitableTermsResultEntity.empty() {
    return const ProfitableTermsResultEntity(
        terms: []
    );
  }

  @override
  List<Object?> get props => [
    terms.length,
  ];
}
