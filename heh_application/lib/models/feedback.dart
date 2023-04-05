class Feedback {
  String feedbackID;
  String? userID;
  String? bookingScheduleID;
  String? comment;
  int? ratingStar;

  Feedback(
      {required this.feedbackID,
      this.userID,
      this.bookingScheduleID,
      this.comment,
      this.ratingStar});

  factory Feedback.fromMap(Map<String, dynamic> json) {
    return Feedback(
        feedbackID: json['feedbackID'],
        userID: json['userID'],
        bookingScheduleID: json['bookingScheduleID'],
        comment: json['comment'],
        ratingStar: json['ratingStar']);
  }
}
