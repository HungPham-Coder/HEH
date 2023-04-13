import 'package:heh_application/models/booking_schedule.dart';
import 'package:heh_application/models/schedule.dart';

class BookingDetail {
  String? bookingDetailID;
  String scheduleID;
  Schedule? schedule;
  String bookingScheduleID;
  BookingSchedule? bookingSchedule;
  bool status;

  BookingDetail(
      { this.bookingDetailID,
      required this.scheduleID,
       this.schedule,
      required this.bookingScheduleID,
       this.bookingSchedule,
      required this.status});
  factory BookingDetail.fromMap(Map<String, dynamic> json) {
    return BookingDetail(
        bookingDetailID: json['bookingDetailID'],
        scheduleID: json['scheduleID'],
        schedule:Schedule.fromMap(json['schedule']) ,
        bookingScheduleID: json['bookingScheduleID'],
        bookingSchedule:BookingSchedule.fromMap(json['bookingSchedule']) ,
        status: json['status']);
  }
}
