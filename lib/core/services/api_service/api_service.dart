import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/constants.dart';

@singleton
@injectable
class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
  ));

  Future<Response> signInUser(
      {required String email, required String password}) async {
    Response response = await _dio.post(signinEndPoint, data: {
      "email": email,
      "password": password,
    });

    return response;
  }
}
