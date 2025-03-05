// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:online_exam/features/exam/data/models/Exam.dart';
import 'package:online_exam/features/exam/data/models/answer_model.dart';

class QuestionsResponse {
  String? question;
  List<AnswerModel>? answers;
  String? correctKey;
  // Exam? examData;
  QuestionsResponse({
    // this.examData,
    this.correctKey,
    this.question,
    this.answers,
  });

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) {
    return QuestionsResponse(
      question: json['questions']['question'],
      answers: json['questions']['answers']
          .map<AnswerModel>((e) => AnswerModel.fromJson(e))
          .toList(),
      correctKey: json['questions']['correct'],
      // examData: Exam.fromJson(
      //   [json['questions']['exam']],
      // ),
    );
  }
}
