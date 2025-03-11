import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';

abstract class GetAllExamsOnSubjectsState {}

class GetAllExamsOnSubjectsIdleState extends GetAllExamsOnSubjectsState {}

class GetAllExamsOnSubjectsLoadingState extends GetAllExamsOnSubjectsState {}

class GetAllExamsOnSubjectsSuccessState extends GetAllExamsOnSubjectsState {
  List<ExamEntity> exams;
  GetAllExamsOnSubjectsSuccessState(this.exams);
}

class GetAllExamsOnSubjectsErrorState extends GetAllExamsOnSubjectsState {
  final String errorMessage;
  GetAllExamsOnSubjectsErrorState(this.errorMessage);
}
