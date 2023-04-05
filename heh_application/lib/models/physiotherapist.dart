class Physiotherapist {
  String physiotherapistID;
  String? specialize;
  String? skill;
  int schedulingStatus;
  int scheduleStatus;
  int workingStatus;

  Physiotherapist(
      {required this.physiotherapistID,
      this.specialize,
      this.skill,
      required this.schedulingStatus,
      required this.scheduleStatus,
      required this.workingStatus});
  factory Physiotherapist.fromMap(Map<String, dynamic> json) {
    return Physiotherapist(
        physiotherapistID: json['physiotherapistID'],
        schedulingStatus: json['schedulingStatus'],
        scheduleStatus: json['scheduleStatus'],
        workingStatus: json['workingStatus']);
  }
}
