import 'package:realtor_pass/features/main/core/models/profitable_terms_model.dart';
import '../entity/profitable_terms_result_entity.dart';

class ProfitableTermsResultModel extends ProfitableTermsResultEntity {
  const ProfitableTermsResultModel({required super.terms});

  factory ProfitableTermsResultModel.fromJson(Map<String, dynamic> json) {
    return ProfitableTermsResultModel(
      terms: List.from(json['data'])
          .map((e) => ProfitableTermsModel.fromJson(e))
          .toList(),
    );
  }
}
