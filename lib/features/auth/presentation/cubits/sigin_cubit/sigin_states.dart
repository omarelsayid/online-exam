import 'package:online_exam/features/auth/domain/entities/user_entity.dart';

sealed class SiginStates {}

class SiginInitial extends SiginStates {}

class SiginLoading extends SiginStates {}

class SiginSuccess extends SiginStates {
  UserEntity userEntity;
  SiginSuccess(this.userEntity);
}

class SiginFailure extends SiginStates {
  final String message;

  SiginFailure(this.message);
}
