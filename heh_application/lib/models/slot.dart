

import 'package:flutter/material.dart';

class Slot {
  String slotID;
  String slotName;

  String timeStart;
  String timeEnd;
  String? description;
  double? price;

  Slot(
      {required this.slotID,
      required this.timeStart,
      required this.timeEnd,
      this.description,
      required this.price,
      required this.slotName});

  factory Slot.fromMap(Map<String, dynamic> json) {
    return Slot(
        slotID: json['slotID'],
        slotName: json['slotName'],
        timeStart: json['timeStart'],
        timeEnd: json['timeEnd'],
        price: double.parse(json['price'].toString()),
        description: json['description']);
  }
}
