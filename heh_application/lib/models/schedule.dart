class Schedule {
  String physiotherapistSlotID;
  String slotID;
  String physiotherapistID;

  Schedule(
      {required this.physiotherapistSlotID,
      required this.slotID,
      required this.physiotherapistID});
  factory Schedule.fromMap(Map<String, dynamic> json) {
    return Schedule(
        physiotherapistSlotID: json['physiotherapistSlotID'],
        slotID: json['slotID'],
        physiotherapistID: json['physiotherapistID']);
  }
}
