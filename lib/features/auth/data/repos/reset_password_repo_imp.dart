import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/core/services/internet_connection_check.dart';
import 'package:online_exam/features/auth/data/data_source.dart/data_source_repo.dart';
import 'package:online_exam/features/auth/domain/repos/reset_password_repo.dart';

@Injectable(as: ResetPasswordRepo)
class ResetPasswordRepoImp implements ResetPasswordRepo {
  final DataSourceRepo _dataSourceRepo;

  ResetPasswordRepoImp(this._dataSourceRepo);

  @override
  Future<Either<ServerFailure, void>> resetPassword(
      {required String email, required String newPassword}) async {
    bool isConnected =
        await (InternetConnectionCheck().getInstance()).hasConnection;
    if (isConnected) {
      return _dataSourceRepo.resetPassword(
          email: email, newPassword: newPassword);
    } else {
      return left(ServerFailure(
          errorMessage:
              "Please check your internet connection and try again later"));
    }
  }
}
