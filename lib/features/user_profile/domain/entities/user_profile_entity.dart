class UserProfileEntity {
  final String? id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? role;
  final bool? isVerified;
  final DateTime? createdAt;
  // final String? passwordResetCode;
  // final DateTime? passwordResetExpires;
  // final bool? resetCodeVerified;

  const UserProfileEntity({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.createdAt,
    // this.passwordResetCode,
    // this.passwordResetExpires,
    // this.resetCodeVerified,
  });
}
