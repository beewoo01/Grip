class CategoryContentDTO {
  int content_idx;
  String content_title;
  String content_description;
  int content_ispro;
  String content_img_url;

  CategoryContentDTO({
    required this.content_idx,
    required this.content_title,
    required this.content_description,
    required this.content_ispro,
    required this.content_img_url,
  });

  factory CategoryContentDTO.fromJson(Map<String, dynamic> json) {
    return CategoryContentDTO(
      content_idx: json["content_idx"],
      content_title: json["content_title"],
      content_description: json["content_description"],
      content_ispro: json["content_ispro"],
      content_img_url: json["content_img_url"],
    );
  }
}
