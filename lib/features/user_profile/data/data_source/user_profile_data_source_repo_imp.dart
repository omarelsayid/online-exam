import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/core/services/auth_service.dart';
import 'package:online_exam/features/user_profile/data/data_source/user_profile_data_source_repo.dart';
import 'package:online_exam/features/user_profile/data/models/user_profile_model.dart';

@Injectable(as: UserProfileDataSourceRepo)
class UserPofileDataSourceRepoImp implements UserProfileDataSourceRepo {
  AuthService authService;
  UserPofileDataSourceRepoImp(this.authService);
  @override
  Future<UserProfileModel> getUserInfo() async {
    Response response = await authService.getUserInfo();
    log(response.data.toString());
    UserProfileModel userProfileModel =
        UserProfileModel.fromJson(response.data);
    return userProfileModel;
  }

  @override
  Future<Either<ServerFailure, void>> updateProfile({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) async {
    try {
      Response response = await authService.updateProfile(
        username: username,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
      );
      UserProfileModel userProfileModel =
          UserProfileModel.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(null);
      } else {
        log(response.data['message'].toString());
        return left(ServerFailure.fromDioException(response.data['message']));
      }
    } on DioException catch (e) {
      log(e.toString());
      return left(ServerFailure.fromDioException(e));
    }
  }
}
