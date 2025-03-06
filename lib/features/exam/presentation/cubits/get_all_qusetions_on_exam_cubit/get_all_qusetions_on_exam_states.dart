import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';

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
  final List<QusetionEntity> qusetionsResponse;
  GetAllQusetionsOnExamSuccessState(this.qusetionsResponse);
}


final class GetAllQusetionsOnExamInitialState
    extends GetAllQusetionsOnExamStates {}
