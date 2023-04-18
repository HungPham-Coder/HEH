import 'package:heh_application/models/exercise_model/exercise_detail.dart';

class ExerciseResource {
  String exerciseResourceID;
  String exerciseDetailID;
  ExerciseDetail1? exerciseDetail1;
  String? resourceName;
  String? videoURL;
  String? imageURL;

  ExerciseResource(
      {required this.exerciseResourceID,
      required this.exerciseDetailID,
      this.exerciseDetail1,
      this.resourceName,
      this.videoURL,
      this.imageURL});

  factory ExerciseResource.fromMap(Map<String, dynamic> json) {
    return ExerciseResource(
        exerciseResourceID: json['exerciseResourceID'],
        exerciseDetailID: json['exerciseDetailID'],
        exerciseDetail1: json['ExerciseDetail'],
        resourceName: json['resourceName'],
        imageURL: json['imageURL'],
        videoURL: json['videoURL']);
  }
}
