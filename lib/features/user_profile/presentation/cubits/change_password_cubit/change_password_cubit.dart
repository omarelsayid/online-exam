import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:online_exam/features/user_profile/domain/repo/logout_repo.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/repo/change_password_repo.dart';

part 'change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {

  ChangePasswordRepo changePasswordRepo;
  LogoutRepo logoutRepo;
  ChangePasswordCubit(this.changePasswordRepo,this.logoutRepo) : super(ChangePasswordInitial());


  void changePassword({
    required String oldPassword,
    required String newPassword,
    required String reNewPassword,
  }) async {
    emit(ChangePasswordLoading());
    Either<ServerFailure, void> response= await changePasswordRepo.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      reNewPassword: reNewPassword,
    );
    response.fold((failure) {
      emit(ChangePasswordError(errorMessage:failure.errorMessage));
    }, (_) {
      emit(ChangePasswordSuccess());
    });
  }


  void logout()
  {
    logoutRepo.logout();
  }

}
