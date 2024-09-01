import '../entity/few_steps_entity.dart';

class FewStepsModel extends FewStepsEntity {
  const FewStepsModel({required super.title});

  factory FewStepsModel.fromJson(Map<String, dynamic> json, {required String locale}) {
    final title = json['${locale}Title'];
    return FewStepsModel(title: title);
  }
}