import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/exam/data/models/Exam.dart';
import 'package:online_exam/features/exam/data/models/Subjects.dart';
import 'package:online_exam/features/exam/data/models/question_model.dart';

abstract class ExamDataSource {
  Future<Either<ServerFailure, List<Subjects>>> getAllSubjects();
  Future<Either<ServerFailure, List<Exam>>> getAllExamsOnSubject(
      {required String subjectId});
  Future<Either<ServerFailure, Exam>> getExamOnId({required String examId});

  Future<QuestionModel> getAllQuestionsOnExam({required String examId});
}
