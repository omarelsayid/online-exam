abstract class VerifyResetCodeViewModelState {}

class VerifyResetCodeIdleState extends VerifyResetCodeViewModelState {}

class VerifyResetCodeLoadingState extends VerifyResetCodeViewModelState {}

class VerifyResetCodeSuccessState extends VerifyResetCodeViewModelState {}

class VerifyResetCodeErrorState extends VerifyResetCodeViewModelState {
  final String errorMessage;
  VerifyResetCodeErrorState(this.errorMessage);
}
