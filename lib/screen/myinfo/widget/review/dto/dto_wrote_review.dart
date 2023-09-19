class WroteReviewDto {
  int content_idx;
  int review_idx;
  String content_title;
  String content_description;
  String? content_img_url;
  String review_title;
  String review_description;
  String? review_img_url;
  String account_name;
  String review_createtime;

  WroteReviewDto(
      {required this.content_idx,
      required this.review_idx,
      required this.content_title,
      required this.content_description,
      required this.content_img_url,
      required this.review_title,
      required this.review_description,
      required this.review_img_url,
      required this.account_name,
      required this.review_createtime});

  factory WroteReviewDto.fromJson(Map<String, dynamic> json) {
    return WroteReviewDto(
      content_idx: json["content_idx"],
      review_idx: json["review_idx"],
      content_title: json["content_title"],
      content_description: json["content_description"],
      content_img_url: json["content_img_url"],
      review_title: json["review_title"],
      review_description: json["review_description"],
      review_img_url: json["review_img_url"],
      account_name: json["account_name"],
      review_createtime: json["review_createtime"],
    );
  }
}
