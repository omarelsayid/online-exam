abstract class UpdateProfileState {}

class UpdateProfileIdleState extends UpdateProfileState {}

class UpdateProfileLoadingState extends UpdateProfileState {}

class UpdateProfileSuccessState extends UpdateProfileState {}

class UpdateProfileErrorState extends UpdateProfileState {
  final String errorMessage;
  UpdateProfileErrorState(this.errorMessage);
}
