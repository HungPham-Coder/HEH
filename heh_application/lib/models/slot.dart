

import 'package:flutter/material.dart';

class Slot {
  String slotID;
  String slotName;

  String timeStart;
  String timeEnd;
  bool available;

  Slot(
      {required this.slotID,
      required this.timeStart,
      required this.timeEnd,

      required this.slotName,
      required this.available
      });

  factory Slot.fromMap(Map<String, dynamic> json) {
    return Slot(
        slotID: json['slotID'],
        slotName: json['slotName'],
        timeStart: json['timeStart'],
        timeEnd: json['timeEnd'],
        available: json['available'],
    );
  }
}
