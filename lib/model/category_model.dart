class CategoryModel {
  int category_idx;
  String category_name;

  CategoryModel({required this.category_idx, required this.category_name});

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
        category_idx: map['category_idx'], category_name: map['category_name']);
  }
}
