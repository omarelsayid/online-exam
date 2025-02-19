abstract class ForgetPasswordViewModelState {}

class ForgetPasswordIdleState extends ForgetPasswordViewModelState {}

class ForgetPasswordLoadingState extends ForgetPasswordViewModelState {}

class ForgetPasswordSuccessState extends ForgetPasswordViewModelState {}

class ForgetPasswordErrorState extends ForgetPasswordViewModelState {
  final String errorMessage;
  ForgetPasswordErrorState(this.errorMessage);
}
