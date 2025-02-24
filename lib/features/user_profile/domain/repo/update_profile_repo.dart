import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';

abstract class UpdateProfileRepo {
  Future<Either<ServerFailure, void>> updateProfile({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  });
}
