import '../entity/questions_result_entity.dart';
import 'questions_model.dart';

class QuestionsResultModel extends QuestionsResultEntity {
  const QuestionsResultModel({required super.questions});
  factory QuestionsResultModel.fromJson(Map<String, dynamic> json) {
    return QuestionsResultModel(
        questions: List.of(json["data"])
            .map((e) => QuestionsModel.fromJson(e))
            .toList());
  }
}
