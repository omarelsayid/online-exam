import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/user_profile/domain/entities/user_profile_entity.dart';

abstract class GetUserProfileRepo {
  Future<Either<ServerFailure, UserProfileEntity>> getUserProfile();
}
