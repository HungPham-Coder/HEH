class FeedbackModel {
  String feedbackID;
  String? userID;
  String? bookingScheduleID;
  String? comment;
  int? ratingStar;

  FeedbackModel(
      {required this.feedbackID,
      this.userID,
      this.bookingScheduleID,
      this.comment,
      this.ratingStar});

  factory FeedbackModel.fromMap(Map<String, dynamic> json) {
    return FeedbackModel(
        feedbackID: json['feedbackID'],
        userID: json['userID'],
        bookingScheduleID: json['bookingScheduleID'],
        comment: json['comment'],
        ratingStar: json['ratingStar']);
  }
}
