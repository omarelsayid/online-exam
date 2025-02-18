class UserEntity {
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  String? token;
  bool? isVerified;
  String? id;
  DateTime? createdAt;
  UserEntity({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.token,
    this.isVerified,
    this.id,
    this.createdAt,
  });
}
