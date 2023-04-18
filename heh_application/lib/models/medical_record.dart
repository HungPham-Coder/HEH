import 'package:heh_application/models/sub_profile.dart';

class MedicalRecord {
  String? medicalRecordID;
  String subProfileID;
  SubProfile? subProfile;
  String? problem;
  String? difficulty;
  String? injury;
  String? curing;
  String? medicine;

  MedicalRecord(
      {this.medicalRecordID,
      required this.subProfileID,
      this.subProfile,
      this.problem,
      this.difficulty,
      this.injury,
      this.curing,
      this.medicine});

  factory MedicalRecord.fromMap(Map<String, dynamic> json) {
    if (json['subProfile'] == null) {
      return MedicalRecord(
        medicalRecordID: json['medicalRecordID'],
        subProfileID: json['subProfileID'],
        problem: json['problem'],
        difficulty: json['difficult'],
        injury: json['injury'],
        curing: json['curing'],
        medicine: json['medicine'],
      );

    }
    else {
      return MedicalRecord(
        medicalRecordID: json['medicalRecordID'],
        subProfileID: json['subProfileID'],
        subProfile: SubProfile.fromMap(json['subProfile']),
        problem: json['problem'],
        difficulty: json['difficult'],
        injury: json['injury'],
        curing: json['curing'],
        medicine: json['medicine'],
      );
    }

  }
}
