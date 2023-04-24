import 'package:heh_application/models/sign_up_user.dart';

class Physiotherapist {
  String physiotherapistID;
  String? skill;
  String? specialize;
  String? userID;
  SignUpUser? signUpUser;
  int scheduleStatus;

  Physiotherapist(
      {required this.physiotherapistID,
      this.skill,
      this.specialize,
      required this.scheduleStatus,
      this.userID,
      this.signUpUser});
  factory Physiotherapist.fromMap(Map<String, dynamic> json) {
    if (json['user'] == null) {
      return Physiotherapist(
          physiotherapistID: json['physiotherapistID'],
          scheduleStatus: json['scheduleStatus'],
          skill: json['skill'],
          specialize: json['specialize']);
    } else {
      return Physiotherapist(
          physiotherapistID: json['physiotherapistID'],
          userID: json['userID'],
          signUpUser: SignUpUser.fromMap(json['user'], ''),
          scheduleStatus: json['scheduleStatus'],
          skill: json['skill'],
          specialize: json['specialize']);
    }
  }
}
