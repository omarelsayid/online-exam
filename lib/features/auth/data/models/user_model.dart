class UserModel {
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  bool? isVerified;
  String? id;
  DateTime? createdAt;

  UserModel({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.id,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        isVerified: json["isVerified"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
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

}
