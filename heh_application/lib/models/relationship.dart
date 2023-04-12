class Relationship {
  String relationId;
  String relationName;
  Relationship({required this.relationId, required this.relationName});
  factory Relationship.fromMap(Map<String, dynamic> json) {
    return Relationship(
        relationId: json['relationId'], relationName: json['relationName']);
  }
}
