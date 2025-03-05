import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/exam/data/models/question_model.dart';

abstract class GetAllQusetionsOnExam {
  Future<Either<ServerFailure, QuestionModel>> getAllQuestionsOnExam(
      {required String examId});
}
