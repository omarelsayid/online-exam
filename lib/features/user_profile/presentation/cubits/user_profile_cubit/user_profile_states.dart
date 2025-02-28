import 'package:online_exam/features/user_profile/domain/entities/user_profile_entity.dart';

sealed class UserProfileStates {}

final class UserProfileInitial extends UserProfileStates {}

final class UserProfileLoading extends UserProfileStates {}

final class UserProfileLoaded extends UserProfileStates {
  final UserProfileEntity userProfileEntity;
  UserProfileLoaded({required this.userProfileEntity});
}

final class UserProfileFailure extends UserProfileStates {
  final String errorMessage;
  UserProfileFailure({required this.errorMessage});
}
