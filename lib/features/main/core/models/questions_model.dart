import '../entity/questions_entity.dart';

class QuestionsModel extends QuestionsEntity {
  const QuestionsModel({required super.name, required super.description});
  factory QuestionsModel.fromEntity(QuestionsEntity entity) {
    return QuestionsModel(name: entity.name, description: entity.description);
  }
  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(name: json["name"], description: json["description"]);
  }
}
