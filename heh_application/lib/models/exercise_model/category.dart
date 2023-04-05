class CategoryModel {
  String categoryID;
  String categoryName;
  String? description;
  CategoryModel(
      {required this.categoryID, required this.categoryName, this.description});
  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(
        categoryID: json['categoryID'],
        categoryName: json['categoryName'],
        description: json['description']);
  }
}
