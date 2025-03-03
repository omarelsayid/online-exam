import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/exam/data/models/Subjects.dart';

abstract class ExamDataSource {
  Future<Either<ServerFailure, List<Subjects>>> getAllSubjects();
  Future<void> getAllExamsOnSubject();
  Future<void> getExamOnId();
}
