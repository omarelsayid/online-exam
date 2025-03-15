

import 'package:online_exam/features/exam/domain/entites/exam_result_entity.dart';

abstract class ExamResultRepository {
  Future<List<ExamResult>> getAllExamResults();
  Future<void> addExamResult(ExamResult examResult);
  Future<void> clearExamResults();
}