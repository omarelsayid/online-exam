

import 'package:online_exam/features/exam/domain/entites/exam_result_entity.dart';

abstract class ExamResultRepository {
  Future<List<ExamResultEntity >> getAllExamResults();
  Future<void> addExamResult(ExamResultEntity  examResult);
  Future<void> clearExamResults();
}
