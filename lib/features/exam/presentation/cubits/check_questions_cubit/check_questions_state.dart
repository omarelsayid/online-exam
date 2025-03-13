import 'package:online_exam/features/exam/data/models/CheckQuestionResponse.dart';

abstract class CheckQuestionsState {}

class CheckQuestionsIdleState extends CheckQuestionsState {}

class CheckQuestionsLoadingState extends CheckQuestionsState {}

class CheckQuestionsSuccessState extends CheckQuestionsState {
  CheckQuestionResponse checkQuestionResponse;
  CheckQuestionsSuccessState(this.checkQuestionResponse);
}

class CheckQuestionsErrorState extends CheckQuestionsState {
  final String errorMessage;
  CheckQuestionsErrorState(this.errorMessage);
}
