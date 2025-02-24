import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/services/secure_storage_service.dart';
import 'package:online_exam/core/utils/constans.dart';
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

  Future<Either<ServerFailure, Response>> signUpUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    try {
      final response = await _dio.post(
        signUpEndPoint,
        data: {
          "username": username,
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          "rePassword": rePassword,
          "phone": phone,
        },
      );
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

  Future<Response> verifyResetCode({required String resetCode}) async {
    Response response = await _dio.post(verifyResetCodeEndPoint, data: {
      "resetCode": resetCode,
    });
    return response;
  }

  Future<Response> resetPassword(
      {required String email, required String newPassword}) async {
    Response response = await _dio.put(resetPasswordEndPoint, data: {
      "email": email,
      "newPassword": newPassword,
    });
    return response;
  }

  Future<Response> getUserInfo() async {
    String? token = await SecureStorageService.getValue(kUserTokenKey);
    Response response = await _dio.get(
      getUserProfileEndPoint,
      options: Options(
        headers: {
          'token': token,
        },
      ),
    );
    return response;
  }

  Future<Response> updateProfile({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) async {
    Response response = await _dio.put(updateProfileEndPoint, data: {
      "username": username,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
    });
    return response;
  }
}
