import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:online_exam/features/auth/presentation/views/sigin_view.dart';
import 'package:online_exam/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
        return ServerFailure.fromResponse(dioExep);
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
  factory ServerFailure.fromResponse(DioException dioExep) {
    final response = dioExep.response;
    if (response == null) {
      return ServerFailure(errorMessage: 'Something went wrong');
    }

    final statusCode = response.statusCode;
    final message = response.data['message'];

    switch (statusCode) {
      case 401:
        switch (message) {
          case '"email" must be a valid email':
            return ServerFailure(errorMessage: 'Not a valid email format');
          case 'incorrect email or password':
            return ServerFailure(errorMessage: 'Incorrect email or password');
          default:
            if (message.contains('fails to match the required pattern')) {
              return ServerFailure(errorMessage: 'Invalid password format');
            } else if (message.contains('invalid token')) {
              Navigator.pushNamed(
                      navigatorKey.currentContext!, SiginView.routeName)
                  .then((_) {
                AwesomeDialog(
                  context: navigatorKey.currentContext!,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: 'Login again',
                  desc: ' with Remember me',
                  dismissOnTouchOutside: false,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              });

              return ServerFailure(errorMessage: 'Login again');
            } else if (message.contains('token not provided')) {
              return ServerFailure(errorMessage: 'Token not provided');
            }
            return ServerFailure(errorMessage: 'Something went wrong');
        }

      case 404:
        if (message.contains('no account')) {
          return ServerFailure(
              errorMessage: 'There is no account with this email address');
        }
        return ServerFailure(errorMessage: 'Something went wrong');

      case 400:
        if (message.contains('invalid or has expired')) {
          return ServerFailure(
              errorMessage: 'Reset code is invalid or has expired');
        }
        return ServerFailure(errorMessage: 'Something went wrong');

      default:
        return ServerFailure(errorMessage: 'Something went wrong');
    }
  }
}
