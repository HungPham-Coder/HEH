import 'package:heh_application/models/schedule.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:heh_application/models/sub_profile.dart';

class BookingSchedule {
  String? bookingScheduleID;
  String userID;
  SignUpUser? signUpUser;
  String subProfileID;
  SubProfile? subProfile;
  String scheduleID;
  Schedule? schedule;
  String dateBooking;
  String timeBooking;
  bool? status;

  BookingSchedule({
    this.bookingScheduleID,
    required this.userID,
    this.signUpUser,
    required this.subProfileID,
    this.subProfile,
    required this.scheduleID,
    this.schedule,
    required this.dateBooking,
    required this.timeBooking,
    this.status
});

  factory BookingSchedule.fromMap (Map<String,dynamic> json){
    return BookingSchedule(
      bookingScheduleID: json['bookingScheduleID'],
        userID: json['userID'],
        signUpUser: SignUpUser.fromMap(json['user'], ''),
        subProfileID: json['subProfileID'],
        subProfile: SubProfile.fromMap(json['subProfile']),
        scheduleID: json['scheduleID'],
        schedule: Schedule.fromMap(json['schedule']),
        dateBooking: json['dateBooking'],
        timeBooking: json['timeBooking'],
      status: json['status'],
    );
  }
}