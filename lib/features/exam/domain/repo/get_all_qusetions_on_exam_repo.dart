import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/exam/data/models/qusetions_response.dart';

abstract class GetAllQusetionsOnExamRepo {
  Future<Either<ServerFailure, QusetionsResponse>> getAllQuestionsOnExam(
      {required String examId});
}
