import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:online_exam/features/user_profile/domain/repo/get_user_profile_repo.dart';
import 'package:online_exam/features/user_profile/presentation/cubits/user_profile_cubit/user_profile_states.dart';

@injectable
class UserProfileCubit extends Cubit<UserProfileStates> {
  GetUserProfileRepo getUserProfileRepo;
  UserProfileCubit(this.getUserProfileRepo) : super(UserProfileInitial());

  Future<Either<ServerFailure, UserProfileEntity>> getUserProfile() async {
    emit(UserProfileLoading());
    final result = await getUserProfileRepo.getUserProfile();
    result.fold(
      (failure) => emit(UserProfileFailure(errorMessage: failure.errorMessage)),
      (userProfileEntity) =>
          emit(UserProfileLoaded(userProfileEntity: userProfileEntity)),
    );
    return result;
  }
}
