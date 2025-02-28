// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/user_profile/data/data_source/user_profile_data_source_repo.dart';
import 'package:online_exam/features/user_profile/data/models/user_profile_model.dart';
import 'package:online_exam/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:online_exam/features/user_profile/domain/repo/get_user_profile_repo.dart';

@Injectable(as: GetUserProfileRepo)
class GetUserProfileRepoImp implements GetUserProfileRepo {
  UserProfileDataSourceRepo userProfileDataSourceRepo;
  GetUserProfileRepoImp(
    this.userProfileDataSourceRepo,
  );
  @override
  Future<Either<ServerFailure, UserProfileEntity>> getUserProfile() async {
    try {
      UserProfileModel userInfoModel =
          await userProfileDataSourceRepo.getUserInfo();
      return Right(userInfoModel.toEntity());
    } on DioException catch (e) {
      log(e.toString() + 'error in get user profile repo');
      return Left(ServerFailure.fromDioException(e));
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
