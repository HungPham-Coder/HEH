import 'package:flutter/material.dart';

class Slot {
  String slotID;
  String typeOfSlotID;
  String physiotherapistID;
  String totalScheduleID;
  String exerciseID;
  DateTime timeStart;
  DateTime timeEnd;
  String duaration;
  String?  description;
  double fee;

  Slot({
      required this.slotID,
      required this.typeOfSlotID,
      required this.physiotherapistID,
      required this.totalScheduleID,
      required this.exerciseID,
      required this.timeStart,
      required this.timeEnd,
      required this.duaration,
      this.description,
      required this.fee});
}