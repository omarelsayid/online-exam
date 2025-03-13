

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class LogoutRepo {
  Future<Either<ServerFailure, void>> logout();
}
