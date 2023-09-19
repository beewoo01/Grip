class MyLikeContentDTO {
  int content_idx;
  String content_title;
  String content_description;
  int like_idx;
  String? content_img_url;

  MyLikeContentDTO({
    required this.content_idx,
    required this.content_title,
    required this.content_description,
    required this.like_idx,
    required this.content_img_url,
  });

  factory MyLikeContentDTO.fromJson(Map<String, dynamic> json) {
    return MyLikeContentDTO(
        content_idx: json["content_idx"],
        content_title: json["content_title"],
        content_description: json["content_description"],
        like_idx: json["like_idx"],
        content_img_url: json["content_img_url"]
    );
  }
}
