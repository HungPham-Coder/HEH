class MedicalRecord {
  String? medicalRecordID;
  String? userID;
  String? categoryID;
  String? subProfile;
  String? problem;
  String? difficulty;
  String? injury;
  String? curing;
  String? medicine;

  MedicalRecord(
      {this.medicalRecordID,
      this.userID,
      this.categoryID,
      this.subProfile,
      this.problem,
      this.difficulty,
      this.injury,
      this.curing,
      this.medicine});

  factory MedicalRecord.fromMap(Map<String, dynamic> json) {
    return MedicalRecord(
      medicalRecordID: json['medicalRecordID'],
      categoryID: json['categoryID'],
      userID: json['userID'],
      subProfile: json['subProfileID'],
      problem: json['problem'],
      difficulty: json['difficult'],
      injury: json['injury'],
      curing: json['curing'],
      medicine: json['medicine'],
    );
  }
}
