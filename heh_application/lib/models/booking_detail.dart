import 'package:heh_application/models/booking_schedule.dart';
import 'package:heh_application/models/schedule.dart';

class BookingDetail {
  String? bookingDetailID;
  String bookingScheduleID;
  BookingSchedule? bookingSchedule;
  String? videoCallRoom;
  bool status;

  BookingDetail(
      { this.bookingDetailID,
      required this.bookingScheduleID,
       this.bookingSchedule,
        this.videoCallRoom,
      required this.status});
  factory BookingDetail.fromMap(Map<String, dynamic> json) {
    return BookingDetail(
        bookingDetailID: json['bookingDetailID'],
        bookingScheduleID: json['bookingScheduleID'],
        bookingSchedule:BookingSchedule.fromMap(json['bookingSchedule']) ,
        videoCallRoom: json['videoCallRoom'],
        status: json['status']);
  }
}
