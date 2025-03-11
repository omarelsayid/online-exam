import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/exam/domain/entites/qusetion_entity.dart';

abstract class GetAllQusetionsOnExamRepo {
  Future<Either<ServerFailure, List<QusetionEntity>>> getAllQuestionsOnExam(
      {required String examId});
}
