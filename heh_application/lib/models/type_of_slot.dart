class TypeOfSlot {
  String typeOfSlotID;
  String slotName;

  TypeOfSlot({required this.typeOfSlotID, required this.slotName});
  factory TypeOfSlot.fromMap (Map<String,dynamic> json){
    return TypeOfSlot(typeOfSlotID: json['typeOfSlotID'], slotName: json['typeOfSlotID']);
  }
}
