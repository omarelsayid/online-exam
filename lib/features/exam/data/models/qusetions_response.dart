import 'package:online_exam/features/exam/data/models/question_model.dart';
import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';

class QusetionsResponse {
  final List<QuestionModel> questions;

  QusetionsResponse({required this.questions});

  factory QusetionsResponse.fromJson(Map<String, dynamic> json) {
    return QusetionsResponse(
      questions: (json['questions'] as List)
          .map((q) => QuestionModel.fromJson(q))
          .toList(),
    );
  }
}
