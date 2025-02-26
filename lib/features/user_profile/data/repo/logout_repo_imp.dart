


import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repo/logout_repo.dart';
import '../data_source/logout_data_source.dart';

@Injectable(as: LogoutRepo)

class LogoutRepoImp implements LogoutRepo {
  final LogoutDataSource dataSource;

  LogoutRepoImp({required this.dataSource});

  @override
  Future<Either<ServerFailure, void>> logout() async {
    return await dataSource.logout();
  }
}