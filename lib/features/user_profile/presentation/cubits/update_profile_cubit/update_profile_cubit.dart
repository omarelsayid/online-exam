import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/user_profile/domain/repo/update_profile_repo.dart';
import 'package:online_exam/features/user_profile/presentation/cubits/update_profile_cubit/update_profile_state.dart';

@injectable
class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileRepo updateProfileRepo;

  UpdateProfileCubit(this.updateProfileRepo) : super(UpdateProfileIdleState());

  void updateProfile({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) async {
    emit(UpdateProfileLoadingState());
    Either<ServerFailure, void> response =
        await updateProfileRepo.updateProfile(
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      username: username,
    );
    response.fold((failure) {
      emit(UpdateProfileErrorState(failure.errorMessage));
    }, (_) {
      emit(UpdateProfileSuccessState());
    });
  }
}
