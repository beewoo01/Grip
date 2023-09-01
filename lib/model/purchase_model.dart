class PurchaseModel {
  int content_idx;
  String content_title;

  PurchaseModel({required this.content_idx, required this.content_title});

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      content_idx: json['content_idx'],
      content_title: json['content_title'],
    );
  }

  @override
  String toString() {
    return '{content_idx : $content_idx , content_title : $content_title}';
  }
}
