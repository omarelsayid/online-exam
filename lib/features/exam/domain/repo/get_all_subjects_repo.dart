import 'package:dartz/dartz.dart';
import 'package:online_exam/features/exam/data/models/Subjects.dart';

import '../../../../core/errors/failures.dart';

abstract class GetAllSubjectsRepo {
  Future<Either<ServerFailure, List<Subjects>>> getAllSubjects();
}
