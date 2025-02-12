import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';

abstract class ForgetPasswordRepo {
  Future<Either<ServerFailure, void>> forgetPassword({required String email});
}
