class PictureByCategoryDTO {
  int content_count;
  int content_idx;
  String content_title;
  String content_latitude;
  String content_longitude;
  String content_img_url;
  int sub_category_idx;
  String sub_category_name;
  String reservation_createtime;

  PictureByCategoryDTO(
      {required this.content_count,
      required this.content_idx,
      required this.content_title,
      required this.content_latitude,
      required this.content_longitude,
      required this.content_img_url,
      required this.sub_category_idx,
      required this.sub_category_name,
      required this.reservation_createtime});

  factory PictureByCategoryDTO.fromJson(Map<String, dynamic> map) {
    return PictureByCategoryDTO(
        content_count : map["content_count"],
        content_idx : map["content_idx"],
        content_title : map["content_title"],
        content_latitude : map["content_latitude"],
        content_longitude : map["content_longitude"],
        content_img_url : map["content_img_url"],
        sub_category_idx : map["sub_category_idx"],
        sub_category_name : map["sub_category_name"],
        reservation_createtime : map["reservation_createtime"],
    );
  }

}
