import 'package:heh_application/models/result_login.dart';

class SignUpUser {
  final String? userID;
  final String? username;
  final String? password;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? address;
  String? _role;

  String? get role => _role;

  set role(String? value) {
    _role = value;
  }
  String? _image;

  String? get image => _image;

  set setImage(String? value) {
    _image = value;
  }

  final String? dob;
  final String? phone;
  final bool? gender;

  SignUpUser(

     {
    this.address,
    String? image,
       String? role,
        this.userID,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
    required this.email,
    required this.gender,
    required this.dob,
  }) : _role = role, _image = image;

  factory SignUpUser.fromMap(Map<String, dynamic> json, String? documentId) {
    return SignUpUser(
      userID: json["id"],
      image: json["image"],
      address: json["address"],
      username: json["Username"],
      password: json["Password"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      dob: json["dob"],
      gender: json["gender"],
      phone: json["phoneNumber"],
    );
  }
}
