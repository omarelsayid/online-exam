import 'Exam.dart';

class ExamResponse {
  String? message;
  Exam? exam;
  ExamResponse({
    this.message,
    this.exam,
  });

  ExamResponse.fromJson(dynamic json) {
    message = json['message'];
    exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
  }

  ExamResponse copyWith({
    String? message,
    Exam? exam,
  }) =>
      ExamResponse(
        message: message ?? this.message,
        exam: exam ?? this.exam,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (exam != null) {
      map['exam'] = exam?.toJson();
    }
    return map;
  }
}
