import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/auth/data/models/user_model.dart';

abstract class DataSourceRepo {
  Future<Either<ServerFailure, UserModel>> signInUser(
      {required String email, required String password});

  Future<Either<ServerFailure, void>> forgetPassword({required String email});

  Future<Either<ServerFailure, void>> verifyResetCode(
      {required String resetCode});

  Future<Either<ServerFailure, void>> resetPassword(
      {required String email, required String newPassword});


  Future<Either<ServerFailure, UserModel>> signUpUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  });
}
