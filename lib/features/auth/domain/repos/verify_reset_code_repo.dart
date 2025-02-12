import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';

abstract class VerifyResetCodeRepo {
  Future<Either<ServerFailure, void>> verifyResetCode(
      {required String resetCode});
}
