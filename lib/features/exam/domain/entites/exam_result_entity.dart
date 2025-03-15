class ExamResult {
  final String examTitle;
  final int totalQuestions;
  final int examDuration;
  final int correctAnswers;
  final int timeTakenMin;
  final int timeTakenSec;
  final List<QuestionResult> questions;
  final DateTime createdAt;

  ExamResult({
    required this.examTitle,
    required this.totalQuestions,
    required this.examDuration,
    required this.correctAnswers,
    required this.timeTakenMin,
    required this.timeTakenSec,
    required this.questions,
    DateTime? createdAt,
  }) : this.createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'examTitle': examTitle,
      'totalQuestions': totalQuestions,
      'examDuration': examDuration,
      'correctAnswers': correctAnswers,
      'timeTakenMin': timeTakenMin,
      'timeTakenSec': timeTakenSec,
      'questions': questions.map((q) => q.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ExamResult.fromJson(Map<String, dynamic> json) {
    return ExamResult(
      examTitle: json['examTitle'],
      totalQuestions: json['totalQuestions'],
      examDuration: json['examDuration'],
      correctAnswers: json['correctAnswers'],
      timeTakenMin: json['timeTakenMin'],
      timeTakenSec: json['timeTakenSec'],
      questions: (json['questions'] as List)
          .map((q) => QuestionResult.fromJson(q))
          .toList(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}

class QuestionResult {
  final String id;
  final String questionText;
  final List<Answer> answers;
  final String correctKey;
  final String? selectedAnswer;
  final int? answerIndex;
  final bool correctAnswer;

  QuestionResult({
    required this.id,
    required this.questionText,
    required this.answers,
    required this.correctKey,
    this.selectedAnswer,
    this.answerIndex,
    required this.correctAnswer,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'answers': answers.map((a) => a.toJson()).toList(),
      'correctKey': correctKey,
      'selectedAnswer': selectedAnswer,
      'answerIndex': answerIndex,
      'correctAnswer': correctAnswer,
    };
  }

  factory QuestionResult.fromJson(Map<String, dynamic> json) {
    return QuestionResult(
      id: json['id'],
      questionText: json['questionText'],
      answers: (json['answers'] as List)
          .map((a) => Answer.fromJson(a))
          .toList(),
      correctKey: json['correctKey'],
      selectedAnswer: json['selectedAnswer'],
      answerIndex: json['answerIndex'],
      correctAnswer: json['correctAnswer'],
    );
  }
}

class Answer {
  final String answer;
  final String key;

  Answer({
    required this.answer,
    required this.key,
  });

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'key': key,
    };
  }

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answer: json['answer'],
      key: json['key'],
    );
  }
}