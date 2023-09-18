class RemainingReviewDTO {
  int reservation_idx;
  int content_content_idx;
  String content_title;
  String reservation_name;
  String reservation_date;
  String? reservation_etc;

  RemainingReviewDTO(
  {required this.reservation_idx,
    required this.content_content_idx,
    required this.content_title,
    required this.reservation_name,
    required this.reservation_date,
    required this.reservation_etc});

  factory RemainingReviewDTO.fromJson(Map<String, dynamic> json ) {
    return RemainingReviewDTO(
        reservation_idx : json["reservation_idx"],
        content_content_idx : json["content_content_idx"],
        content_title : json["content_title"],
        reservation_name : json["reservation_name"],
        reservation_date : json["reservation_date"],
        reservation_etc : json["reservation_etc"],
    );
  }
}