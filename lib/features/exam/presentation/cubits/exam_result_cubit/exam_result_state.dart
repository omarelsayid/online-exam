part of 'exam_result_cubit.dart';

@immutable
sealed class ExamResultState {}

final class ExamResultInitial extends ExamResultState {}


class ExamResultLoading extends ExamResultState{}
class ExamResultSuccess extends ExamResultState{
  final List<ExamResult> examResults;
  ExamResultSuccess(this.examResults);
}
class ExamResultError extends ExamResultState{
  final String message;
  ExamResultError(this.message);
}
