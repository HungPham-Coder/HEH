import 'package:heh_application/models/result_login.dart';
import 'package:heh_application/models/role.dart';

class SignUpUser {
  final String? userID;
  final String? password;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? address;
  String? _image;

  String? get image => _image;

  set setImage(String? value) {
    _image = value;
  }

  final String? dob;
  final String? phone;
  final bool? gender;
  String? roleID;
  Role? role;
  // final String? gender;

  SignUpUser(
      {this.address,
      String? image,
      this.userID,
      required this.firstName,
      this.lastName,
      required this.phone,
      required this.password,
      required this.email,
      required this.gender,
      this.dob,
      this.roleID,
      this.role})
      : _image = image;

  factory SignUpUser.fromMap(Map<String, dynamic> json, String? documentId) {
    return SignUpUser(
        userID: json["id"],
        image: json["image"],
        address: json["address"],
        password: json["Password"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: json["dob"],
        gender: json["gender"],
        phone: json["phoneNumber"],
        roleID: json['roleID'],
        role: Role.fromMap(json['role']));
  }
}
