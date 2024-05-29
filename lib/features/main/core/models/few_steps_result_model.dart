import '../entity/few_steps_result_entity.dart';
import 'few_steps_model.dart';

class FewStepsResultModel extends FewStepsResultEntity {
  const FewStepsResultModel({required super.steps});
  factory FewStepsResultModel.fromJson(Map<String, dynamic> json) {
    return FewStepsResultModel(
        steps: json["data"] == null
            ? []
            : List.from(json["data"])
                .map((e) => FewStepsModel.fromJson(e))
                .toList());
  }
}
