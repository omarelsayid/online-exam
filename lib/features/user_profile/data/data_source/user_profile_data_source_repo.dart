import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/user_profile/data/models/user_profile_model.dart';

abstract class UserProfileDataSourceRepo {
  Future<UserProfileModel> getUserInfo();

  Future<Either<ServerFailure, void>> updateProfile({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  });
}
