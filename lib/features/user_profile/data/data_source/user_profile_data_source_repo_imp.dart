import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
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
}
