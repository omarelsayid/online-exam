abstract class ResetPasswordViewModelState {}

class ResetPasswordIdleState extends ResetPasswordViewModelState {}

class ResetPasswordLoadingState extends ResetPasswordViewModelState {}

class ResetPasswordSuccessState extends ResetPasswordViewModelState {}

class ResetPasswordErrorState extends ResetPasswordViewModelState {
  final String errorMessage;
  ResetPasswordErrorState(this.errorMessage);
}
