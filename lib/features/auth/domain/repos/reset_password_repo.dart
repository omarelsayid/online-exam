import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';

abstract class ResetPasswordRepo {
  Future<Either<ServerFailure, void>> resetPassword(
      {required String email, required String newPassword});
}
