import 'WrongQuestions.dart';
import 'CorrectQuestions.dart';

class CheckQuestionResponse {
  String? message;
  num? correct;
  num? wrong;
  String? total;
  List<WrongQuestions>? wrongQuestions;
  List<CorrectQuestions>? correctQuestions;
  CheckQuestionResponse({
    this.message,
    this.correct,
    this.wrong,
    this.total,
    this.wrongQuestions,
    this.correctQuestions,
  });

  CheckQuestionResponse.fromJson(dynamic json) {
    message = json['message'];
    correct = json['correct'];
    wrong = json['wrong'];
    total = json['total'];
    if (json['WrongQuestions'] != null) {
      wrongQuestions = [];
      json['WrongQuestions'].forEach((v) {
        wrongQuestions?.add(WrongQuestions.fromJson(v));
      });
    }
    if (json['correctQuestions'] != null) {
      correctQuestions = [];
      json['correctQuestions'].forEach((v) {
        correctQuestions?.add(CorrectQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['correct'] = correct;
    map['wrong'] = wrong;
    map['total'] = total;
    if (wrongQuestions != null) {
      map['WrongQuestions'] = wrongQuestions?.map((v) => v.toJson()).toList();
    }
    if (correctQuestions != null) {
      map['correctQuestions'] =
          correctQuestions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
