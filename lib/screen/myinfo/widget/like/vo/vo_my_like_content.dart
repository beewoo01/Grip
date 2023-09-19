class MyLikeContentVO {
  final int content_idx;
  final String content_title;
  final String content_description;
  final int like_idx;
  final String? content_img_url;

  MyLikeContentVO(this.content_idx, this.content_title,
      this.content_description, this.like_idx, this.content_img_url
      );
}