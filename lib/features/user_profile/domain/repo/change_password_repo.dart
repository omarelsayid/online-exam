
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class ChangePasswordRepo {
  Future<Either<ServerFailure,void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String reNewPassword,
  });
}
