import 'package:online_exam/features/exam/data/models/qusetions_response.dart';

sealed class GetAllQusetionsOnExamStates {}

final class GetAllQusetionsOnExamLoadingState
    extends GetAllQusetionsOnExamStates {}

final class GetAllQusetionsOnExamErrorState
    extends GetAllQusetionsOnExamStates {
  final String errorMessage;
  GetAllQusetionsOnExamErrorState(this.errorMessage);
}

final class GetAllQusetionsOnExamSuccessState
    extends GetAllQusetionsOnExamStates {
  final QusetionsResponse qusetionsResponse;
  GetAllQusetionsOnExamSuccessState(this.qusetionsResponse);
}


final class GetAllQusetionsOnExamInitialState
    extends GetAllQusetionsOnExamStates {}
