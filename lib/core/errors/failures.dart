import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException(DioException dioExep) {
    switch (dioExep.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMessage: 'Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Recive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: 'Bad SSL certificate error');
      case DioExceptionType.badResponse:
        if (dioExep.response!.statusCode == 401) {
          if (dioExep.response!.data['message'] ==
              "\"email\" must be a valid email") {
            return ServerFailure(errorMessage: 'not valid email format');
          } else if (dioExep.response!.data['message'] ==
              "incorrect email or password") {
            return ServerFailure(errorMessage: 'incorrect email or password');
          } else if (dioExep.response!.data['message']
              .contains('fails to match the required pattern')) {
            return ServerFailure(errorMessage: 'invalid password format');
          } else {
            return ServerFailure(errorMessage: 'somthing went wrong');
          }
        } else if (dioExep.response!.statusCode == 404) {
          if (dioExep.response!.data['message'].contains('no account')) {
            return ServerFailure(
                errorMessage: 'There is no account with this email address');
          }
          return ServerFailure(errorMessage: 'somthing went wrong');
        } else if (dioExep.response!.statusCode == 400) {
          if (dioExep.response!.data['message']
              .contains('invalid or has expired')) {
            return ServerFailure(
                errorMessage: 'Reset code is invalid or has expired');
          }
          return ServerFailure(errorMessage: 'somthing went wrong');
        }
        return ServerFailure(errorMessage: 'bad reponse from ApiServer');
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: 'There is no internet connection');
      case DioExceptionType.unknown:
        return ServerFailure(
            errorMessage: 'Unexcepted error , Please try again');
      default:
        return ServerFailure(
            errorMessage: 'Oops there is an error , Please try later');
    }
  }
}
