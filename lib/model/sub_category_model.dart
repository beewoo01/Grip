class SubCategoryModel {
  late int category_idx;
  late String category_name;
  late int sub_category_idx;
  late String sub_category_name;

  SubCategoryModel(
      {required this.category_idx,
      required this.category_name,
      required this.sub_category_idx,
      required this.sub_category_name});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      category_idx: json['category_idx'],
      category_name: json['category_name'],
      sub_category_idx: json['sub_category_idx'],
      sub_category_name: json['sub_category_name'],
    );
  }

  @override
  String toString() {
    return 'category_idx : $category_idx, category_name : $category_name, sub_category_idx : $sub_category_idx, sub_category_name : $sub_category_name';
  }
}
