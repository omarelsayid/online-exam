class UserAnswerModel {
  String? questionId;
  String? correct;
  UserAnswerModel({
    this.questionId,
    this.correct,
  });

  UserAnswerModel.fromJson(dynamic json) {
    questionId = json['questionId'];
    correct = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['questionId'] = questionId;
    map['correct'] = correct;
    return map;
  }
}
