import 'package:dartz/dartz.dart';
import 'package:online_exam/features/exam/domain/entites/exam_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class GetAllExamsOnSubjectRepo {
  Future<Either<ServerFailure, List<ExamEntity>>> getAllExamsOnSubject(
      {required String subjectId});
}
