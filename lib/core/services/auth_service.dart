import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/custom_exception.dart';
import 'package:online_exam/core/utils/constants.dart';
import 'package:online_exam/core/errors/failures.dart';

@singleton
@injectable
class AuthService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
  ));

  Future<Either<ServerFailure, Response>> signInUser(
      {required String email, required String password}) async {
    try {
      Response response = await _dio.post(signinEndPoint, data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 401) {
        if (response.data['message'] == "\"email\" must be a valid email") {
          throw CustomException('not valid email format');
        } else if (response.data['message'] == "incorrect email or password") {
          throw CustomException('incorrect email or password');
        }
      }
      return right(response);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    }
  }
}
