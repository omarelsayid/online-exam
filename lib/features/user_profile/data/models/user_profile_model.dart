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
      id: json['_id'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      isVerified: json['isVerified'],
      // createdAt: DateTime.parse(json['createdAt']),
      // passwordResetCode: json['passwordResetCode'],
      // passwordResetExpires: DateTime.parse(json['passwordResetExpires']),
      // resetCodeVerified: json['resetCodeVerified'],
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
