class ContentModel {
  int content_idx;
  int sub_category_sub_category_idx;
  String content_title;
  String content_description;
  String content_address;
  String content_latitude;
  String content_longitude;
  int content_ispro;
  String content_updatetime;
  String content_createtime;

  ContentModel(
      {required this.content_idx,
      required this.sub_category_sub_category_idx,
      required this.content_title,
      required this.content_description,
      required this.content_address,
      required this.content_latitude,
      required this.content_longitude,
      required this.content_ispro,
      required this.content_updatetime,
      required this.content_createtime});

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      content_idx: json['content_idx'],
      sub_category_sub_category_idx: json['sub_category_sub_category_idx'],
      content_title: json['content_title'],
      content_description: json['content_description'],
      content_address: json['content_address'],
      content_latitude: json['content_latitude'],
      content_longitude: json['content_longitude'],
      content_ispro: json['content_ispro'],
      content_updatetime: json['content_updatetime'],
      content_createtime: json['content_createtime'],
    );
  }

  @override
  String toString() {
    return 'content_idx : $content_idx sub_category_idx : $sub_category_sub_category_idx content_title : $content_title';
  }
}
