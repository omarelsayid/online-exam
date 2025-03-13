import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';

abstract class GetExamOnIdState {}

class GetExamOnIdIdleState extends GetExamOnIdState {}

class GetExamOnIdLoadingState extends GetExamOnIdState {}

class GetExamOnIdSuccessState extends GetExamOnIdState {
  ExamEntity exam;
  GetExamOnIdSuccessState(this.exam);
}

class GetExamOnIdErrorState extends GetExamOnIdState {
  final String errorMessage;
  GetExamOnIdErrorState(this.errorMessage);
}
