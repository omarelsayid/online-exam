import '../../../domain/entities/user_entity.dart';

sealed class SignupStates {}

class SignupInitial extends SignupStates {}

class SignupLoading extends SignupStates {}

class SignupSuccess extends SignupStates {
  final UserEntity userEntity;
  SignupSuccess(this.userEntity);
}

class SignupFailure extends SignupStates {
  final String message;

  SignupFailure(this.message);
}
