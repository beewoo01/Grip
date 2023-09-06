class InquiryModel {
  int inquiry_idx;
  String sources;
  String inquiry_title;
  String inquiry_description;
  int? inquiry_image_idx;
  String? inquiry_image_url;

  InquiryModel(
      {required this.inquiry_idx,
      required this.sources,
      required this.inquiry_title,
      required this.inquiry_description,
      required this.inquiry_image_idx,
      required this.inquiry_image_url});

  factory InquiryModel.fromJson(Map<String, dynamic> json) {
    return InquiryModel(
      inquiry_idx: json['inquiry_idx'],
      sources: json['sources'],
      inquiry_title: json['inquiry_title'],
      inquiry_description: json['inquiry_description'],
      inquiry_image_idx: json['inquiry_image_idx'],
      inquiry_image_url: json['inquiry_image_url'],
    );
  }

  @override
  String toString() {
    return 'inquiry_idx : $inquiry_idx, sources : $inquiry_idx, inquiry_title : $inquiry_title,inquiry_description : $inquiry_description,inquiry_image_idx : $inquiry_image_idx, inquiry_image_url : $inquiry_image_url';
  }
}
