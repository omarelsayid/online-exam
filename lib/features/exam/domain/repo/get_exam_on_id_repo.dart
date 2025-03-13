import 'package:dartz/dartz.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class GetExamOnIdRepo {
  Future<Either<ServerFailure, ExamEntity>> getExamOnId(
      {required String examId});
}
