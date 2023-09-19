class RemainingReviewDTO {
  int reservation_idx;
  int content_idx;
  String content_title;
  String content_description;
  String reservation_name;
  String reservation_date;
  String? reservation_etc;
  String? content_img_url;

  RemainingReviewDTO(
      {required this.reservation_idx,
      required this.content_idx,
      required this.content_title,
      required this.content_description,
      required this.reservation_name,
      required this.reservation_date,
      required this.reservation_etc,
      required this.content_img_url,
      });

  factory RemainingReviewDTO.fromJson(Map<String, dynamic> json) {
    return RemainingReviewDTO(
      reservation_idx: json["reservation_idx"],
      content_idx: json["content_idx"],
      content_title: json["content_title"],
      content_description: json["content_description"],
      reservation_name: json["reservation_name"],
      reservation_date: json["reservation_date"],
      reservation_etc: json["reservation_etc"],
      content_img_url: json["content_img_url"],
    );
  }
}
