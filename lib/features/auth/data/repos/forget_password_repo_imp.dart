import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/auth/data/data_source.dart/data_source_repo.dart';
import 'package:online_exam/features/auth/domain/repos/forget_password_repo.dart';

@Injectable(as: ForgetPasswordRepo)
class ForgetPasswordRepoImp implements ForgetPasswordRepo {
  final DataSourceRepo _dataSourceRepo;
  final InternetConnectionChecker internetConnectionChecker;

  ForgetPasswordRepoImp(this._dataSourceRepo, this.internetConnectionChecker);

  @override
  Future<Either<ServerFailure, void>> forgetPassword(
      {required String email}) async {
    bool isConnected = await internetConnectionChecker.hasConnection;
    if (isConnected) {
      return _dataSourceRepo.forgetPassword(email: email);
    } else {
      return left(ServerFailure(
          errorMessage:
              "Please check your internet connection and try again later"));
    }
  }
}
