// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:online_exam/features/exam/data/models/answer_model.dart';

class QusetionEntity {
  String? id;
  String? question;
  List<AnswerModel>? answers;
  String? correctKey;
  QusetionEntity({
    this.id,
    this.question,
    this.answers,
    this.correctKey,
  });
}
