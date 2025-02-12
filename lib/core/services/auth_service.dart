import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/utils/end_points.dart';
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

      return right(response);
    } on DioException catch (e) {
      log(ServerFailure.fromDioException(e).errorMessage);
      return left(ServerFailure.fromDioException(e));
    }
  }

  Future<Response> forgetPassword({required String email}) async {
    Response response = await _dio.post(forgetPasswordEndPoint, data: {
      "email": email,
    });
    return response;
  }

  Future<Response> verifyCodeReset({required String resetCode}) async {
    Response response = await _dio.post(verifyResetCodeEndPoint, data: {
      "resetCode": resetCode,
    });
    return response;
  }
}
