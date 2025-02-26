import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/auth_service.dart';

abstract class LogoutDataSource {
  Future<Either<ServerFailure, void>> logout();
}

@Injectable(as: LogoutDataSource)
class LogoutDataSourceImp implements LogoutDataSource {
  AuthService authService;

  LogoutDataSourceImp(this.authService);

  @override
  Future<Either<ServerFailure, void>> logout() async {
    try {
      Response response = await authService.logout();
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(null);
      } else {
        return left(ServerFailure(errorMessage: response.data['message']));
      }
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    }
  }
}
