import 'package:heh_application/models/slot.dart';
import 'physiotherapist.dart';
class Schedule {
  String scheduleID;
  String slotID;
  Slot slot;
  String physiotherapistID;
  Physiotherapist physiotherapist;

  Schedule(
      {required this.scheduleID,
      required this.slotID,
      required this.physiotherapistID,
      required this.slot,
        required this.physiotherapist
      });
  factory Schedule.fromMap(Map<String, dynamic> json) {
    return Schedule(
        scheduleID: json['physiotherapistSlotID'],
        slotID: json['slotID'],
        physiotherapistID: json['physiotherapistID'],
        slot: Slot.fromMap(json['slot']),
      physiotherapist: Physiotherapist.fromMap(json['physiotherapistDetail'])
    );

  }
}
