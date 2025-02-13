import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/core/services/auth_service.dart';
import 'package:online_exam/features/auth/data/data_source.dart/data_source_repo.dart';
import 'package:online_exam/features/auth/data/models/user_model.dart';

@Injectable(as: DataSourceRepo)
class DataSourceImp implements DataSourceRepo {
  final AuthService _authService;

  DataSourceImp(this._authService);

  @override
  Future<Either<ServerFailure, UserModel>> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _authService.signInUser(email: email, password: password);

      return result.fold(
        (failure) => left(failure), // Propagate the failure
        (response) {
          // Directly return the response data
          return right(UserModel.fromJson(response.data));
        },
      );
    } on Exception catch (e) {
      return left(ServerFailure(
          errorMessage: "An unexpected error occurred: ${e.toString()}"));
      // Catch any unexpected errors and wrap them in a ServerFailure
      // return left(ServerFailure("An unexpected error occurred: ${e.toString()}"));
    }
  }

//===============================
// signUp implementation
//================================

  Future<Either<ServerFailure, UserModel>> signUpUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    try{

      final result = await _authService.signUpUser(
         username:username,
         firstName:firstName,
        lastName:lastName,
         email:email,
         password:password,
         rePassword:rePassword,
         phone:phone,
      );

      return result.fold(
          (failure) =>left(failure),
          (response)=> right(UserModel.fromJson(response.data))
      );
      
    }on Exception catch(e){
      return left(ServerFailure(errorMessage:  "An unexpected error occurred: ${e.toString()}"));
    }
    

  }

}
