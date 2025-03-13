import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';

sealed class GetAllQuestionOnExamStates {}

final class GetAllQusetionsOnExamLoadingState
    extends GetAllQuestionOnExamStates {}

final class GetAllQusetionsOnExamErrorState extends GetAllQuestionOnExamStates {
  final String errorMessage;
  GetAllQusetionsOnExamErrorState(this.errorMessage);
}

final class GetAllQusetionsOnExamSuccessState
    extends GetAllQuestionOnExamStates {
  final List<QusetionEntity> qusetionsResponse;
  GetAllQusetionsOnExamSuccessState(this.qusetionsResponse);
}

final class GetAllQusetionsOnExamInitialState
    extends GetAllQuestionOnExamStates {}
