// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:online_exam/features/exam/data/models/answer_model.dart';
import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';

class QuestionModel {
  String? id;
  String? question;
  List<AnswerModel>? answers;
  int? correctKey;

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
      correctKey: int.parse(
              json['correct'].replaceAll(RegExp(r'[^0-9]'), '') as String) -
          1,
    );
  }

  QusetionEntity toQusetionEntity() {
    return QusetionEntity(
      id: id,
      question: question,
      answers: answers,
      correctKey: correctKey,
    );
  }
}
