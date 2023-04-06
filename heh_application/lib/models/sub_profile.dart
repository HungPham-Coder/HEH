class SubProfile {
  String profileID;
  String medicalRecordID;
  String profileName;

  SubProfile(
      {required this.profileID,
      required this.medicalRecordID,
      required this.profileName});
  factory SubProfile.fromMap(Map<String, dynamic> json) {
    return SubProfile(
        profileID: json['profileID'],
        medicalRecordID: json['medicalRecordID'],
        profileName: json['profileName']);
  }
}
