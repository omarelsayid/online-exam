class UserAnswerEntity {
  final String? questionId;
  final String? userAnswer;
  final String? correctAnswer;
  int? answerIndex;
  UserAnswerEntity(
      {this.questionId, this.userAnswer, this.correctAnswer, this.answerIndex});
}
