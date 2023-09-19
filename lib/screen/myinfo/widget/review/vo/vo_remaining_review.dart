class RemainingReviewVO {
  final int reservation_idx;
  final int content_idx;
  final String content_title;
  final String content_description;
  final String reservation_name;
  final String reservation_date;
  final String? reservation_etc;
  final String? content_img_url;

  RemainingReviewVO(
      this.reservation_idx,
      this.content_idx,
      this.content_title,
      this.content_description,
      this.reservation_name,
      this.reservation_date,
      this.reservation_etc,
      this.content_img_url);
}