class WeddingVO {
  final int content_idx;
  final String content_title;
  final String content_img_url;

  WeddingVO(this.content_idx, this.content_title, this.content_img_url);

  @override
  String toString() {
    return "content_idx : $content_idx, content_title : $content_title, content_img_url : $content_img_url";
  }
}