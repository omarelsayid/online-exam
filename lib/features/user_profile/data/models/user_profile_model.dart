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
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["_id"],
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        isVerified: json["isVerified"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

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
      );
}
