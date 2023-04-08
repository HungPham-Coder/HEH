import 'package:heh_application/models/sign_up_user.dart';

class Physiotherapist {
  String physiotherapistID;
  String? skill;
  String? specialize;
  SignUpUser signUpUser;
  int scheduleStatus;
  int workingStatus;


  Physiotherapist(
      {required this.physiotherapistID,
      this.skill,
      this.specialize,

      required this.scheduleStatus,
      required this.workingStatus,
      required this.signUpUser
      });
  factory Physiotherapist.fromMap(Map<String, dynamic> json) {
    return Physiotherapist(
        physiotherapistID: json['physiotherapistID'],
        signUpUser: SignUpUser.fromMap(json['user'], ''),
        scheduleStatus: json['scheduleStatus'],
        workingStatus: json['workingStatus'],
    skill: json['skill'],
    specialize:  json['specialize']);
  }
}
