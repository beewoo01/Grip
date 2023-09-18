class RemainingReviewVO {
  final int reservation_idx;
  final int content_content_idx;
  final String content_title;
  final String reservation_name;
  final String reservation_date;
  final String? reservation_etc;

  RemainingReviewVO(
      this.reservation_idx,
      this.content_content_idx,
      this.content_title,
      this.reservation_name,
      this.reservation_date,
      this.reservation_etc);
}