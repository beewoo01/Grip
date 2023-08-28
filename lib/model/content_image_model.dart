class ContentImageModel {
  int content_img_idx;
  String content_img_url;
  int content_content_idx;

  ContentImageModel(
      {required this.content_img_idx,
      required this.content_img_url,
      required this.content_content_idx});

  factory ContentImageModel.fromJson(Map<String, dynamic> json) {
    return  ContentImageModel(
        content_img_idx : json['content_img_idx'],
        content_img_url : json['content_img_url'],
        content_content_idx : json['content_content_idx']
    );


  }

  @override
  String toString() {
    return 'content_img_idx : $content_img_idx content_img_url : $content_img_url content_content_idx : $content_content_idx';
  }

}
