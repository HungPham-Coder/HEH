class ExerciseResource {
  String exerciseResourceID;
  String resourceName;
  String? videoURL;
  String? imageURL;

  ExerciseResource(
      {required this.exerciseResourceID,
      required this.resourceName,
      this.videoURL,
      this.imageURL});

  factory ExerciseResource.fromMap(Map<String, dynamic> json) {
    return ExerciseResource(
        exerciseResourceID: json['exerciseResourceID'],
        resourceName: json['resourceName'],
        imageURL: json['imageURL'],
        videoURL: json['videoURL']);
  }
}
