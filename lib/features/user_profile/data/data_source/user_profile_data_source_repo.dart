import 'package:online_exam/features/user_profile/data/models/user_profile_model.dart';

abstract class UserProfileDataSourceRepo {
  Future<UserProfileModel> getUserInfo();
}
