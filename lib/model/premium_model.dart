class PremiumModel {
  int premium_idx;
  int content_idx;
  String content_title;
  String content_description;
  String content_address;
  String content_latitude;
  String content_longitude;
  String? content_img_url;
  int? like_idx;

  PremiumModel({required this.premium_idx,
    required this.content_idx,
    required this.content_title,
    required this.content_description,
    required this.content_address,
    required this.content_latitude,
    required this.content_longitude,
    required this.content_img_url,
    required this.like_idx});

  factory PremiumModel.fromJson(Map<String, dynamic> json) {
    return PremiumModel(
      premium_idx: json['premium_idx'],
      content_idx: json['content_idx'],
      content_title: json['content_title'],
      content_description: json['content_description'],
      content_address: json['content_address'],
      content_latitude: json['content_latitude'],
      content_longitude: json['content_longitude'],
      content_img_url: json['content_img_url'],
      like_idx: json['like_idx'],
    );
  }
}