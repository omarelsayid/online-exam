class AnswerModel {
  final String answer;
  final String key;

  AnswerModel({required this.answer, required this.key});

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      answer: json['answer'],
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'key': key,
    };
  }
}
