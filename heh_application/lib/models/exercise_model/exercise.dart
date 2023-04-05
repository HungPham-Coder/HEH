class Exercise {
  String exerciseID;
  String exerciseName;
  int? exerciseTimePerWeek;
  Exercise(
      {required this.exerciseID,
      required this.exerciseName,
      this.exerciseTimePerWeek});
  factory Exercise.fromMap(Map<String, dynamic> json) {
    return Exercise(
        exerciseID: json['exerciseID'],
        exerciseName: json['exerciseName'],
        exerciseTimePerWeek: json['exerciseTimePerWeek']);
  }
}
