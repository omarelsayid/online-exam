
import 'package:dartz/dartz.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/auth/domain/entities/user_entity.dart';

abstract class SignUpRepo{

  Future<Either<ServerFailure,UserEntity>> signUpUser({
    required String userName,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  });



}
