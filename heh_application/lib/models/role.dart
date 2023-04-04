class Role {
 String id;
 String name;
 String description;
 Role ({required this.id, required this.name, required this.description});
  factory Role.fromMap (Map<String, dynamic> json){
    return Role(id: json["id"], name: json["name"], description: json["description"]);
  }
}