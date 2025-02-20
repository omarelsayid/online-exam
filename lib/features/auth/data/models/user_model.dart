import 'package:online_exam/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  // Constructor for UserModel
  UserModel({
    String? token,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    bool? isVerified,
    String? id,
    DateTime? createdAt,
  }) : super(
          token: token,
          username: username,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          role: role,
          isVerified: isVerified,
          id: id,
          createdAt: createdAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json['token'],
        username: json['user']["username"],
        firstName: json['user']["firstName"],
        lastName: json['user']["lastName"],
        email: json['user']["email"],
        phone: json['user']["phone"],
        role: json['user']["role"],
        isVerified: json['user']["isVerified"],
        id: json['user']["_id"],
        createdAt: DateTime.parse(json['user']["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "role": role,
        "isVerified": isVerified,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
      };

  UserEntity toEntity() => UserEntity(
        token: token,
        username: username,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        role: role,
        isVerified: isVerified,
        id: id,
        createdAt: createdAt,
      );
}
