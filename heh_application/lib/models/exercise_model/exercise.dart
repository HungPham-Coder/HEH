import 'package:heh_application/models/exercise_model/category.dart';

class Exercise {
  String exerciseID;
  String exerciseName;
  String categoryID;
  CategoryModel? categoryModel;
  int? exerciseTimePerWeek;
  String? iconUrl;
  bool? flag;
  bool? status;

  Exercise(
      {required this.exerciseID,
      required this.exerciseName,
        required this.categoryID,
        this.categoryModel,
      this.exerciseTimePerWeek,
      this.iconUrl,
        this.flag,
        this.status,

      });
  factory Exercise.fromMap(Map<String, dynamic> json) {
    return Exercise(
        exerciseID: json['exerciseID'],
        exerciseName: json['exerciseName'],
        categoryID: json['categoryID'],
        categoryModel: CategoryModel.fromMap(json['category']),
        exerciseTimePerWeek: json['exerciseTimePerWeek'],
        iconUrl: json['iconUrl'],
      flag: json['flag'],
      status: json['status'],
    );
  }
}
