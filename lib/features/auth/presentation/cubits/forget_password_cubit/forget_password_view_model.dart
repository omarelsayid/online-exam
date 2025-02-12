import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/core/utils/base_api_state.dart';
import 'package:online_exam/features/auth/domain/repos/forget_password_repo.dart';
import 'package:online_exam/features/auth/presentation/cubits/forget_password_cubit/forget_password_state.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordViewModelState> {
  ForgetPasswordRepo forgetPasswordRepo;
  ForgetPasswordViewModel(this.forgetPasswordRepo)
      : super(ForgetPasswordViewModelState.initial());

  void forgetPassword({required String email}) async {
    emit(ForgetPasswordViewModelState(BaseLoadingState()));
    Either<ServerFailure, void> response =
        await forgetPasswordRepo.forgetPassword(email: email);
    response.fold((failure) {
      emit(ForgetPasswordViewModelState(BaseErrorState(failure.errorMessage)));
    }, (_) {
      emit(ForgetPasswordViewModelState(BaseSuccessState(null)));
    });
  }
}
