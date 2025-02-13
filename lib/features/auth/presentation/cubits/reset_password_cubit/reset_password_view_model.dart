import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/features/auth/domain/repos/reset_password_repo.dart';
import 'package:online_exam/features/auth/presentation/cubits/reset_password_cubit/reset_password_state.dart';

@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordViewModelState> {
  ResetPasswordRepo resetPasswordRepo;
  ResetPasswordViewModel(this.resetPasswordRepo)
      : super(ResetPasswordIdleState());

  void resetPassword(
      {required String email, required String newPassword}) async {
    emit(ResetPasswordLoadingState());
    Either<ServerFailure, void> response = await resetPasswordRepo
        .resetPassword(email: email, newPassword: newPassword);
    response.fold((failure) {
      emit(ResetPasswordErrorState(failure.errorMessage));
    }, (_) {
      emit(ResetPasswordSuccessState());
    });
  }
}
