import '../entity/few_steps_result_entity.dart';
import 'few_steps_model.dart';

class FewStepsResultModel extends FewStepsResultEntity {
  const FewStepsResultModel({required super.steps});

  factory FewStepsResultModel.fromJson(List<dynamic> json, {String locale = 'en'}) {
    return FewStepsResultModel(
      steps: json.isEmpty
          ? []
          : json.map((e) => FewStepsModel.fromJson(e , locale: locale)).toList(),
    );
  }
}
