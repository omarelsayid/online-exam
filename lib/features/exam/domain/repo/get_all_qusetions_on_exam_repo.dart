import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/exam/data/models/questions_response.dart';

abstract class GetAllQusetionsOnExam {
  Future<Either<ServerFailure, QuestionsResponse>> getAllQuestionsOnExam(
      {required String examId});
}
