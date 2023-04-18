import 'package:heh_application/models/schedule.dart';

class FeedbackModel {
  String feedbackID;
  String? scheduleID;
  Schedule? schedule;
  String? comment;
  int? ratingStar;

  FeedbackModel(
      {required this.feedbackID,
      this.scheduleID,
      this.schedule,
      this.comment,
      this.ratingStar});

  factory FeedbackModel.fromMap(Map<String, dynamic> json) {
    return FeedbackModel(
        feedbackID: json['feedbackID'],
        scheduleID: json['scheduleID'],
        schedule: json['schedule'],
        comment: json['comment'],
        ratingStar: json['ratingStar']);
  }
}
