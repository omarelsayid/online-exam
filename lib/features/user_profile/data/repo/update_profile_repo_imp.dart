import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/user_profile/data/data_source/user_profile_data_source_repo.dart';
import 'package:online_exam/features/user_profile/domain/repo/update_profile_repo.dart';

@Injectable(as: UpdateProfileRepo)
class UpdateProfileRepoImp implements UpdateProfileRepo {
  final UserProfileDataSourceRepo _userProfileDataSourceRepo;
  final InternetConnectionChecker internetConnectionChecker;

  UpdateProfileRepoImp(
      this._userProfileDataSourceRepo, this.internetConnectionChecker);

  @override
  Future<Either<ServerFailure, void>> updateProfile({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) async {
    bool isConnected = await internetConnectionChecker.hasConnection;
    if (isConnected) {
      return _userProfileDataSourceRepo.updateProfile(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        username: username,
      );
    } else {
      return left(ServerFailure(
          errorMessage:
              "Please check your internet connection and try again later"));
    }
  }
}
