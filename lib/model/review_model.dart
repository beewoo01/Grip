class ReviewModel {
  int review_idx;
  String review_title;
  String review_description;
  int account_idx;
  int content_idx;
  int sub_category_idx;
  String sub_category_name;
  int category_idx;
  String category_name;
  String review_img_url;

  ReviewModel(
      {required this.review_idx,
      required this.review_title,
      required this.review_description,
      required this.account_idx,
      required this.content_idx,
      required this.sub_category_idx,
      required this.sub_category_name,
      required this.category_idx,
      required this.category_name,
      required this.review_img_url});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      review_idx: json['review_idx'],
      review_title: json['review_title'],
      review_description: json['review_description'],
      account_idx: json['account_account_idx'],
      content_idx: json['content_idx'],
      sub_category_idx: json['sub_category_idx'],
      sub_category_name: json['sub_category_name'],
      category_idx: json['category_idx'],
      category_name: json['category_name'],
      review_img_url: json['review_img_url'],
    );
  }
}
