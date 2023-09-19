class WroteReviewVO {
  final int content_idx;
  final int review_idx;
  final String content_title;
  final String content_description;
  final String? content_img_url;
  final String review_title;
  final String review_description;
  final String? review_img_url;
  final String account_name;
  final String review_createtime;

  WroteReviewVO(
      this.content_idx,
      this.review_idx,
      this.content_title,
      this.content_description,
      this.content_img_url,
      this.review_title,
      this.review_description,
      this.review_img_url,
      this.account_name,
      this.review_createtime);
}
