class CategoryModel {
  final String categoryName;
  final String categoryImage;

  CategoryModel({required this.categoryName , required this.categoryImage});

   factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryName: map['categoryName'] ?? '',
      categoryImage: map['categoryImage'] ?? '',
    );
  }
}
