class BookingDetail {
  String userID;
  String profileID;
  String slotID;
  DateTime timeBooking;
  double price;
  bool status;

  BookingDetail(
      {required this.userID,
      required this.profileID,
      required this.slotID,
      required this.timeBooking,
      required this.price,
      required this.status});
  factory BookingDetail.fromMap(Map<String, dynamic> json) {
    return BookingDetail(
        userID: json['userID'],
        profileID: json['profileID'],
        slotID: json['slotID'],
        timeBooking: json['timeBooking'],
        price: json['price'],
        status: json['price']);
  }
}
