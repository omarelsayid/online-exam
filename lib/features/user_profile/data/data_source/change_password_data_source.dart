import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/auth_service.dart';

abstract class ChangePasswordDataSource {


  Future<Either<ServerFailure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String reNewPassword,
  });
}

@Injectable(as: ChangePasswordDataSource)
class ChangePasswordDataSourceImp implements ChangePasswordDataSource {
  AuthService authService;

  ChangePasswordDataSourceImp(this.authService);

  @override
  Future<Either<ServerFailure, void>> changePassword({required String oldPassword, required String newPassword, required String reNewPassword}) async{
    try{
      Response response =await authService.changePassword(oldPassword: oldPassword,
          newPassword: newPassword,
          reNewPassword: reNewPassword);
      if(response.statusCode! >= 200 && response.statusCode! < 300){

        return Right(null);
      }
      else{
        return left(ServerFailure(errorMessage: response.data['message']));
      }
    }on DioException catch(e){
      print("=======================Error ======");
      print(e.toString());
      return left(ServerFailure.fromDioException(e));
    }
  }



}
