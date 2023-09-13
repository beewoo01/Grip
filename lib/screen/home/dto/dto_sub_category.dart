class SubCategoryDTO {
  int category_idx;
  String? category_name;
  int sub_category_idx;
  String sub_category_name;

  SubCategoryDTO({
    required this.category_idx,
    required this.category_name,
    required this.sub_category_idx,
    required this.sub_category_name,
  });

  factory SubCategoryDTO.fromJson(Map<String, dynamic> map) {
    return SubCategoryDTO(
        category_idx : map["category_idx"],
        category_name : map["category_name"],
        sub_category_idx : map["sub_category_idx"],
        sub_category_name : map["sub_category_name"],
    );
  }
}
