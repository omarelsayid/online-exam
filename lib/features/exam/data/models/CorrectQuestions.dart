class CorrectQuestions {
  String? qid;
  String? question;
  String? correctAnswer;
  dynamic answers;
  CorrectQuestions({
    this.qid,
    this.question,
    this.correctAnswer,
    this.answers,
  });

  CorrectQuestions.fromJson(dynamic json) {
    qid = json['QID'];
    question = json['Question'];
    correctAnswer = json['correctAnswer'];
    answers = json['answers'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['QID'] = qid;
    map['Question'] = question;
    map['correctAnswer'] = correctAnswer;
    map['answers'] = answers;
    return map;
  }
}
