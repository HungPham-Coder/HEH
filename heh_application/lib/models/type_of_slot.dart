class TypeOfSlot {
  String typeOfSlotID;
  double price;
  String typeName;

  TypeOfSlot(
      {required this.typeOfSlotID,
      required this.typeName,
      required this.price});
  factory TypeOfSlot.fromMap(Map<String, dynamic> json) {
    return TypeOfSlot(
        typeOfSlotID: json['typeOfSlotID'], typeName: json['typeName'],
      price: json['price']
    );
  }
}
