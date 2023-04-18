import 'package:heh_application/models/relationship.dart';
import 'package:heh_application/models/sign_up_user.dart';

class SubProfile {
  String? profileID;
  String? userID;
  SignUpUser? signUpUser;
  String? relationID;
  Relationship? relationship;

  String subName;

  String? dob;
  SubProfile(
      {this.profileID,
      this.userID,
      this.signUpUser,
      required this.relationID,
      this.relationship,
      required this.subName,
      this.dob});

  factory SubProfile.fromMap(Map<String, dynamic> json) {
    if (json['user'] == null || json['relationship'] == null) {
      return SubProfile(
          profileID: json['profileID'],
          userID: json['userID'],
          relationID: json['relationId'],
          subName: json['subName'],
          dob: json['dateOfBirth']);
    } else {
      return SubProfile(
          profileID: json['profileID'],
          userID: json['userID'],
          signUpUser: SignUpUser.fromMap(json['user'], ''),
          relationID: json['relationId'],
          relationship: Relationship.fromMap(json['relationship']),
          subName: json['subName'],
          dob: json['dateOfBirth']);
    }
  }
}
