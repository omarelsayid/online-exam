import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:online_exam/core/errors/failures.dart';

import '../../domain/repo/change_password_repo.dart';
import '../data_source/user_profile_data_source_repo.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImp implements ChangePasswordRepo {
  final ChangePasswordDataSource changePasswordDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  ChangePasswordRepoImp(
      this.changePasswordDataSource,this.internetConnectionChecker

      );

  @override
  Future<Either<ServerFailure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String reNewPassword,
  }) async {
    bool isConnected = await internetConnectionChecker.hasConnection;

    print("=============Connection Status: $isConnected");
    if (isConnected) {
      return changePasswordDataSource.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          reNewPassword: reNewPassword);
    } else {
      return left(ServerFailure(
          errorMessage:
              "Please check your internet connection and try again later"));
    }
  }
}
