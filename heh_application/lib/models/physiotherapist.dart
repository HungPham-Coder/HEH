class Physiotherapist {
  String physiotherapistID;
  String? specialize;
  String? experience;
  int schedulingStatus;
  int scheduleStatus;
  int workingStatus;

  Physiotherapist(
      {required this.physiotherapistID,
      this.specialize,
      this.experience,
      required this.schedulingStatus,
      required this.scheduleStatus,
      required this.workingStatus});
  factory Physiotherapist.fromMap(Map<String, dynamic> json) {
    return Physiotherapist(
        physiotherapistID: json['physiotherapistID'],
        schedulingStatus: json['schedulingStatus'],
        scheduleStatus: json['scheduleStatus'],
        workingStatus: json['workingStatus'],
    experience: json['skill'],
    specialize: json['specialize']);
  }
}
