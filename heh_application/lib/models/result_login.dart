import 'package:heh_application/models/role.dart';

class ResultLogin {
  final String? accessToken;
  final String? userID;
  final String? username;
  final String? firstName;
  final String? phoneNumber;
  final String? lastName;
  final Role? role;
  ResultLogin({
     this.accessToken,
     this.userID,
     this.username,
    required this.firstName,
     this.phoneNumber,
     this.lastName,
     this.role
  });
  factory ResultLogin.fromMap(Map<String, dynamic> json) {
    return ResultLogin(
        accessToken: json["access_token"],
        userID: json["userID"],
        username: json["username"],
        firstName: json["firstName"],
        phoneNumber: json["phoneNumber"],
        lastName: json["lastName"],
      role: Role.fromMap(json["role"])
    );
  }
}
