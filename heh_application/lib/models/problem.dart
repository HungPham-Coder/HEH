import 'package:heh_application/models/exercise_model/category.dart';
import 'package:heh_application/models/medical_record.dart';

class Problem1 {
  String? problemID;
  String categoryID;
  CategoryModel? categoryModel;
  String medicalRecordID;
  MedicalRecord? medicalRecord;
  Problem1({
     this.problemID,
    required this.categoryID,
    this.categoryModel,
    required this.medicalRecordID,
    this.medicalRecord,
  });
  factory Problem1.FromMap(Map<String, dynamic> json) {
    return Problem1(
        problemID: json['problemID'],
        categoryID: json['categoryID'],
        categoryModel: CategoryModel.fromMap(json['Category']),
        medicalRecordID: json['medicalRecordID'],
        medicalRecord: MedicalRecord.fromMap(json['MedicalRecord'])
    );
  }
}
