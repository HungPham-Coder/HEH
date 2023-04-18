class CategoryModel {
  String categoryID;
  String categoryName;
  String? description;
  String? iconUrl;
  CategoryModel(
      {required this.categoryID,
      required this.categoryName,
      this.description,
      this.iconUrl});
  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(
        categoryID: json['categoryID'],
        categoryName: json['categoryName'],
        description: json['description'],
        iconUrl: json['iconUrl']);
  }
}
