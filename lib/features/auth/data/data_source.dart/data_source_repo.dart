import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/auth/data/models/user_model.dart';

abstract class DataSourceRepo {
  Future<Either<ServerFailure, UserModel>> signInUser(
      {required String email, required String password});
}
