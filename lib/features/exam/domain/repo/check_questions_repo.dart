import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/exam/data/models/CheckQuestionResponse.dart';

abstract class CheckQuestionsRepo {
  Future<Either<ServerFailure, CheckQuestionResponse>> checkQuestions(
      {required List<Map<String, dynamic>> answers});
}
