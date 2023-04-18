import 'package:heh_application/models/exercise_model/exercise.dart';

class ExerciseDetail1 {
  String exerciseDetailID;
  String exerciseID;
  Exercise? exercise;
  String? detailName;
  String? set;
  String description;
  ExerciseDetail1({
    required this.exerciseDetailID,
    required this.exerciseID,
    this.exercise,
    required this.description,
    this.set,
    this.detailName,
  });
  factory ExerciseDetail1.fromMap(Map<String, dynamic> json) {
    return ExerciseDetail1(
        exerciseDetailID: json['exerciseDetailID'],
        exerciseID: json['exerciseID'],
        detailName: json['detailName'],
        set: json['set'],
        description: json['description'],);
  }
}
