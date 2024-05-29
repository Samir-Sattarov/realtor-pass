import '../entity/few_steps_entity.dart';

class FewStepsModel extends FewStepsEntity {
  const FewStepsModel({required super.title});
  factory FewStepsModel.fromJson(Map<String, dynamic> json) {
    return FewStepsModel(title: json['title']);
  }
}
