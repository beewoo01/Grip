import 'package:grip/api/ApiService.dart';
import 'package:grip/model/content_detail_model.dart';
import 'package:grip/model/review_model.dart';

import '../model/content_image_model.dart';

class CommunityViewModel {
  final ApiService apiService = ApiService();
  List<ReviewModel>? reviewList;
  ContentDetailModel? contentDetailModel;
  List<ContentImageModel> contentImageList = [];

  Future<List<ReviewModel>?> selectReview() async {
    List<ReviewModel>? reviewList = await apiService.selectReview();
    this.reviewList = reviewList;
    if(reviewList != null) {
      print('reviewList');
      print(reviewList);
      return reviewList;
    }
    return null;
  }

  Future<ContentDetailModel?> selectContentDetail(int contentIdx) async {
    print('CommunityViewModel selectContentDetail');
    ContentDetailModel? contentDetailModel = await apiService.selectContentDetail(2);
    List<ContentImageModel>? contentImageList = await apiService.selectContentImage(2);
    if(contentDetailModel != null) {
      print('contentDetailModel != null');
      this.contentDetailModel = contentDetailModel;

      if(contentImageList != null) {
        print('selectContentImage != null');
        print('contentImageList.length ${contentImageList.length}');
        print('$contentImageList');
        this.contentImageList = contentImageList;
      }
      //selectContentImage(contentIdx);

      return contentDetailModel;
    }

    return null;
  }

  Future<List<ContentImageModel>?> selectContentImage(int contentIdx) async {
    List<ContentImageModel>? contentImageList = await apiService.selectContentImage(contentIdx);
    if(contentImageList != null) {
      print('selectContentImage != null');
      this.contentImageList = contentImageList;
      return contentImageList;
    }

    return null;
  }
}