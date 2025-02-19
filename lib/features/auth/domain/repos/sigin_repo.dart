import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/auth/domain/entities/user_entity.dart';

abstract class SigninRepo {
  Future<Either<ServerFailure, UserEntity>> signInUser({
    required String email,
    required String password,
  });
}
