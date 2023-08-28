class ContentDetailModel {
  final int? content_idx;
  final String? content_title;
  final String? content_description;
  final String? content_address;
  final String? content_latitude;
  final String? content_longitude;
  final String? struct_name;
  final String? struct_description;

  ContentDetailModel({
    required this.content_idx,
    required this.content_title,
    required this.content_description,
    required this.content_address,
    required this.content_latitude,
    required this.content_longitude,
    required this.struct_name,
    required this.struct_description
  });




  factory ContentDetailModel.fromJson(Map<String, dynamic> json) {
    return ContentDetailModel(
        content_idx : json['content_idx'],
        content_title : json['content_title'],
        content_description : json['content_description'],
        content_address : json['content_address'],
        content_latitude : json['content_latitude'],
        content_longitude : json['content_longitude'],
        struct_name : json['struct_name'],
        struct_description : json['struct_description']
    );
  }
}