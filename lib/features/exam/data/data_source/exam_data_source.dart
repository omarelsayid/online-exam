import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/exam/data/models/CheckQuestionResponse.dart';
import 'package:online_exam/features/exam/data/models/Exam.dart';
import 'package:online_exam/features/exam/data/models/Subjects.dart';
import 'package:online_exam/features/exam/data/models/qusetions_response.dart';

abstract class ExamDataSource {
  Future<Either<ServerFailure, List<Subjects>>> getAllSubjects();
  Future<Either<ServerFailure, List<Exam>>> getAllExamsOnSubject(
      {required String subjectId});
  Future<Either<ServerFailure, Exam>> getExamOnId({required String examId});

  Future<QusetionsResponse> getAllQuestionsOnExam({required String examId});

  Future<Either<ServerFailure, CheckQuestionResponse>> checkQuestions(
      {required List<Map<String, dynamic>> answers});
}
