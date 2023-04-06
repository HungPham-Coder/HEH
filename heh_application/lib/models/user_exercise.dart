class UserExercise {
  String userExerciseID;
  String exerciseID;
  String userID;
  DateTime duarationTime;
  bool status;

  UserExercise(
      {required this.userExerciseID,
      required this.exerciseID,
      required this.userID,
      required this.duarationTime,
      required this.status});
  factory UserExercise.fromMap(Map<String, dynamic> json) {
    return UserExercise(
        userExerciseID: json['userExerciseID'],
        exerciseID: json['exerciseID'],
        userID: json['userID'],
        duarationTime: json['duarationTime'],
        status: json['status']);
  }
}
