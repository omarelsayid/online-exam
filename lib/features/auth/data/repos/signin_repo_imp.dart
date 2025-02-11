import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/auth/data/data_source.dart/data_source_repo.dart';
import 'package:online_exam/features/auth/domain/entities/user_entity.dart';
import 'package:online_exam/features/auth/domain/repos/sigin_repo.dart';

@Injectable(as: SigninRepo)
class SigninRepoImp implements SigninRepo {
  final DataSourceRepo _dataSourceRepo;

  SigninRepoImp(this._dataSourceRepo);

  @override
  Future<Either<ServerFailure, UserEntity>> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _dataSourceRepo.signInUser(email: email, password: password);

      return result.fold(
        (failure) => left(failure),
        (userModel) => right(userModel.toEntity()),
      );
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
