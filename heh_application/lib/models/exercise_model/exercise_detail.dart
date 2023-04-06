class ExerciseDetail1 {
  String exerciseDetailID;
  String exerciseID;
  String categoryID;
  String? exerciseTimePerSet;
  String description;
  ExerciseDetail1(
      {required this.exerciseDetailID,
      required this.exerciseID,
      required this.categoryID,
      required this.description,
      this.exerciseTimePerSet});
  factory ExerciseDetail1.fromMap(Map<String, dynamic> json) {
    return ExerciseDetail1(
        exerciseDetailID: json['exerciseDetailID'],
        exerciseID: json['exerciseID'],
        categoryID: json['categoryID'],
        description: json['description'],
    exerciseTimePerSet: json['exerciseTimePerSet']);
  }
}
