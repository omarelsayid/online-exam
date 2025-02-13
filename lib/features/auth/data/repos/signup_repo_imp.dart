import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:online_exam/core/errors/failures.dart';

import 'package:online_exam/features/auth/domain/entities/user_entity.dart';

import '../../domain/repos/signup_repo.dart';
import '../data_source.dart/data_source_repo.dart';

@Injectable(as: SignUpRepo)
class SignUpRepoImp implements SignUpRepo {
  final DataSourceRepo _dataSourceRepo;

  SignUpRepoImp(this._dataSourceRepo);

  @override
  Future<Either<ServerFailure, UserEntity>> signUpUser(
      {required String userName,
      required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String rePassword,
      required String phone}) async {
    try {
      final result = await _dataSourceRepo.signUpUser(
        username: userName,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone,
      );

      return result.fold(
            (failure) => left(failure),
            (userModel) => right(userModel.toEntity()),
      );
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
