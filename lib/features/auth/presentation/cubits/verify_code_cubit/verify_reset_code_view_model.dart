import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/errors/failures.dart';
import 'package:online_exam/core/utils/base_api_state.dart';
import 'package:online_exam/features/auth/domain/repos/verify_reset_code_repo.dart';
import 'package:online_exam/features/auth/presentation/cubits/verify_code_cubit/verify_reset_code_state.dart';

@injectable
class VerifyResetCodeViewModel extends Cubit<VerifyResetCodeViewModelState> {
  VerifyResetCodeRepo verifyResetCodeRepo;
  VerifyResetCodeViewModel(this.verifyResetCodeRepo)
      : super(VerifyResetCodeViewModelState.initial());

  void verifyResetCode({required String resetCode}) async {
    emit(VerifyResetCodeViewModelState(BaseLoadingState()));
    Either<ServerFailure, void> response =
        await verifyResetCodeRepo.verifyResetCode(resetCode: resetCode);
    response.fold((failure) {
      emit(VerifyResetCodeViewModelState(BaseErrorState(failure.errorMessage)));
    }, (_) {
      emit(VerifyResetCodeViewModelState(BaseSuccessState(null)));
    });
  }
}
