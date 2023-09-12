class WeddingDTO {
  int content_idx;
  String content_title;
  int content_img_idx;
  String content_img_url;

  WeddingDTO(
      {required this.content_idx,
      required this.content_title,
      required this.content_img_idx,
      required this.content_img_url});

  factory WeddingDTO.fromJson(Map<String, dynamic> map) {
    return WeddingDTO(
      content_idx: map["content_idx"],
      content_title: map["content_title"],
      content_img_idx: map["content_img_idx"],
      content_img_url: map["content_img_url"],
    );
  }
}
