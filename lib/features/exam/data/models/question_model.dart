// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:online_exam/features/exam/data/models/answer_model.dart';

class QuestionModel {
  String? id;
  String? question;
  List<AnswerModel>? answers;
  String? correctKey;

  QuestionModel({
    this.id,
    this.question,
    this.answers,
    this.correctKey,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['_id'],
      question: json['question'],
      answers: (json['answers'] as List)
          .map((e) => AnswerModel.fromJson(e))
          .toList(),
      correctKey: json['correct'],
    );
  }
}
