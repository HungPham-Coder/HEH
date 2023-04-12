import 'package:heh_application/models/slot.dart';
import 'package:heh_application/models/type_of_slot.dart';
import 'physiotherapist.dart';
class Schedule {
  String scheduleID;
  String slotID;
  Slot slot;
  String physiotherapistID;
  Physiotherapist physiotherapist;
  String typeOfSlotID;
  TypeOfSlot typeOfSlot;
  String description;
  bool physioBookingStatus;
  String day;
  Schedule(
      {required this.scheduleID,
      required this.slotID,
        required this.slot,
      required this.physiotherapistID,
        required this.physiotherapist,
        required this.typeOfSlotID,
        required this.typeOfSlot,
        required this.description,
        required this.physioBookingStatus,
        required this.day
      });
  factory Schedule.fromMap(Map<String, dynamic> json) {
    return Schedule(
        scheduleID: json['scheduleID'],
        slotID: json['slotID'],
        slot: Slot.fromMap(json['slot']),
        physiotherapistID: json['physiotherapistID'],
        physiotherapist: Physiotherapist.fromMap(json['physiotherapistDetail']),
        typeOfSlotID: json['typeOfSlotID'],
        typeOfSlot: TypeOfSlot.fromMap(json['typeOfSlot']),
        description: json['description'],
      physioBookingStatus: json['physioBookingStatus'],
      day: json['day']
    );

  }
}
