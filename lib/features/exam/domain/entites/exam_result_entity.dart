class ExamResultEntity {
  final String examTitle;
  final int totalQuestions;
  final int examDuration;
  final int correctAnswers;
  final int timeTakenMin;
  final int timeTakenSec;
  final List<QuestionResultEntity> questions;

  ExamResultEntity({
    required this.examTitle,
    required this.totalQuestions,
    required this.examDuration,
    required this.correctAnswers,
    required this.timeTakenMin,
    required this.timeTakenSec,
    required this.questions,
  });

  Map<String, dynamic> toJson() {
    return {
      'examTitle': examTitle,
      'totalQuestions': totalQuestions,
      'examDuration': examDuration,
      'correctAnswers': correctAnswers,
      'timeTakenMin': timeTakenMin,
      'timeTakenSec': timeTakenSec,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }

  factory ExamResultEntity.fromJson(Map<String, dynamic> json) {
    return ExamResultEntity(
      examTitle: json['examTitle'],
      totalQuestions: json['totalQuestions'],
      examDuration: json['examDuration'],
      correctAnswers: json['correctAnswers'],
      timeTakenMin: json['timeTakenMin'],
      timeTakenSec: json['timeTakenSec'],
      questions: (json['questions'] as List)
          .map((q) => QuestionResultEntity.fromJson(q))
          .toList(),
    );
  }
}

class QuestionResultEntity {
  final String id;
  final String questionText;
  final List<AnswerEntity>? answers;
  final String correctKey;
  final String? selectedAnswer;
  final int? answerIndex;
  final String? correctAnswer;

  QuestionResultEntity({
    required this.id,
    required this.questionText,
    required this.answers,
    required this.correctKey,
    required this.selectedAnswer,
    required this.answerIndex,
    required this.correctAnswer,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'answers': answers?.map((a) => a.toJson()).toList(),
      'correctKey': correctKey,
      'selectedAnswer': selectedAnswer,
      'answerIndex': answerIndex,
      'correctAnswer': correctAnswer,
    };
  }

  factory QuestionResultEntity.fromJson(Map<String, dynamic> json) {
    return QuestionResultEntity(
      id: json['id'],
      questionText: json['questionText'],
      answers: json['answers'] != null
          ? (json['answers'] as List)
          .map((a) => AnswerEntity.fromJson(a))
          .toList()
          : null,
      correctKey: json['correctKey'],
      selectedAnswer: json['selectedAnswer'],
      answerIndex: json['answerIndex'],
      correctAnswer: json['correctAnswer'],
    );
  }
}

class AnswerEntity {
  final String answer;
  final String key;

  AnswerEntity({
    required this.answer,
    required this.key,
  });

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'key': key,
    };
  }

  factory AnswerEntity.fromJson(Map<String, dynamic> json) {
    return AnswerEntity(
      answer: json['answer'],
      key: json['key'],
    );
  }
}
