
import '../entity/profitable_terms_entity.dart';

class ProfitableTermsModel extends ProfitableTermsEntity {
  const ProfitableTermsModel({required super.title, required super.description,});

  factory ProfitableTermsModel.fromJson(Map<String, dynamic> json) {
    return ProfitableTermsModel(

      title: json['name'],
      description: json['description'],
    );
  }
}