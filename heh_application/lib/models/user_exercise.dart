import 'package:heh_application/models/exercise_model/exercise_detail.dart';
import 'package:heh_application/models/sign_up_user.dart';

class UserExercise {
  String userExerciseID;
  String exerciseDetailID;
  ExerciseDetail1? exerciseDetail1;
  String userID;
  SignUpUser? signUpUser;
  DateTime duarationTime;
  bool status;

  UserExercise(
      {required this.userExerciseID,
      required this.exerciseDetailID,
        this.exerciseDetail1,
      required this.userID,
        this.signUpUser,
      required this.duarationTime,
      required this.status});
  factory UserExercise.fromMap(Map<String, dynamic> json) {
    return UserExercise(
        userExerciseID: json['userExerciseID'],
        exerciseDetailID: json['exerciseDetailID'],
        exerciseDetail1: ExerciseDetail1.fromMap(json['ExerciseDetail']),
        userID: json['userID'],
        signUpUser: SignUpUser.fromMap(json['User'], ''),
        duarationTime: json['duarationTime'],
        status: json['status']);
  }
}
