// exam_result_state.dart
part of 'exam_result_cubit.dart';

abstract class ExamResultState {}

class ExamResultInitial extends ExamResultState {}

class ExamResultLoading extends ExamResultState {}

class ExamResultSuccess extends ExamResultState {
  final List<ExamResultEntity> examResults;
  ExamResultSuccess(this.examResults);
}

class ExamResultError extends ExamResultState {
  final String message;
  ExamResultError(this.message);
}
