class MedicalRecord {
  String? medicalRecordID;
  String? presentIllness;
  String? pastMedical;
  String? categoryID;

  MedicalRecord(
      { this.medicalRecordID,
      this.presentIllness,
      this.pastMedical,
      this.categoryID});
  factory MedicalRecord.fromMap(Map<String, dynamic> json) {
    return MedicalRecord(
        medicalRecordID: json['medicalRecordID'],
        categoryID: json['categoryID'],
        pastMedical: json['pastMedical'],
        presentIllness: json['presentIllness']);
  }
}
