import 'package:online_exam/features/user_profile/domain/entities/user_profile_entity.dart';

class UserProfileModel {
  final String? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? role;
  final bool? isVerified;
  final DateTime? createdAt;
  final String? passwordResetCode;
  final DateTime? passwordResetExpires;
  final bool? resetCodeVerified;

  UserProfileModel({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.createdAt,
    this.passwordResetCode,
    this.passwordResetExpires,
    this.resetCodeVerified,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['user']['_id'],
      username: json['user']['username'],
      firstName: json['user']['firstName'],
      lastName: json['user']['lastName'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      role: json['user']['role'],
      isVerified: json['user']['isVerified'],
      createdAt: DateTime.parse(json['user']['createdAt']),
      passwordResetCode: json['user']['passwordResetCode'],
      passwordResetExpires:
          DateTime.parse(json['user']['passwordResetExpires']),
      resetCodeVerified: json['user']['resetCodeVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'role': role,
      'isVerified': isVerified,
      'createdAt': createdAt!.toIso8601String(),
      'passwordResetCode': passwordResetCode,
      'passwordResetExpires': passwordResetExpires!.toIso8601String(),
      'resetCodeVerified': resetCodeVerified,
    };
  }

  UserProfileEntity toEntity() => UserProfileEntity(
        id: id,
        username: username,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        role: role,
        isVerified: isVerified,
        createdAt: createdAt,
        passwordResetCode: passwordResetCode,
        passwordResetExpires: passwordResetExpires,
        resetCodeVerified: resetCodeVerified,
      );
}
