import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure{
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
            // here i need to check on response and statuscode 

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
