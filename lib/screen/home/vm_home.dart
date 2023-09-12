import 'package:grip/api/ApiService.dart';
import 'package:grip/model/premium_model.dart';
import 'package:grip/screen/home/dto/dto_picture_by_category.dart';
import 'package:grip/screen/home/dto/dto_sub_category.dart';
import 'package:grip/screen/home/vo/vo_event.dart';
import 'package:grip/screen/home/vo/vo_pictures_by_category.dart';
import 'package:grip/screen/home/vo/vo_sub_category.dart';
import 'package:grip/screen/home/vo/vo_wedding.dart';

import '../../model/review_model.dart';
import 'dto/dto_wedding.dart';

class HomeViewModel {
  final ApiService apiService = ApiService();
  List<PremiumModel>? premiumList = [];
  List<Event> eventList = [];
  List<ReviewModel> reviewList = [];

  List<WeddingVO> weddingList = [];
  List<PicturesByCategoryVO> picturesByCategoryList = [];
  List<SubCategoryVO> subCategoryList = [];

  Future<List<PremiumModel>?> selectPremiumModel(int accountIdx) async {
    List<PremiumModel>? list = await apiService.selectPremium(accountIdx);
    if (list != null) {
      premiumList?.clear();
      premiumList?.addAll(list);
      return list;
    }

    return null;
  }

  Future<int> insertLike(int contentIdx, int accountIdx) async {
    int result = await apiService.insertLike(contentIdx, accountIdx);
    return result;
  }

  Future<int> deleteLike(int likeIdx) async {
    int result = await apiService.deleteLike(likeIdx);
    return result;
  }

  Future<List<Event>> selectEvent() async {
    List<Event> list = await apiService.selectEvent() ?? [];
    eventList.clear();
    eventList.addAll(list.map((e) => Event(
          e.event_idx,
          e.event_title,
          e.event_description,
          e.event_img_idx,
          e.event_img_url,
        )));
    return list;
  }

  Future<void> selectReview() async {
    List<ReviewModel>? reviewList = await apiService.selectReview();
    if (reviewList != null) {
      this.reviewList = reviewList;
    }
  }

  Future<void> selectWeddingPhoto() async {
    List<WeddingDTO> result = await apiService.selectWeddingPhoto() ?? [];
    List<WeddingVO> res = [];
    weddingList.clear();
    print("selectWeddingPhoto result.length");
    print("selectWeddingPhoto ${result.length}");
    for (var model in result) {
      res.add(WeddingVO(model.content_idx, model.content_title, model.content_img_url));
    }

    print("selectWeddingPhoto res");
    print("${res.length}");
    weddingList.addAll(res);
  }

  Future<void> selectPicturesByCategory(int categoryIdx) async {
    List<PictureByCategoryDTO>? result =
        await apiService.selectPicturesByCategory(categoryIdx);
    List<PicturesByCategoryVO> res = [];
    result?.map((e) => {
          res.add(PicturesByCategoryVO(
              e.content_count, e.content_title, e.content_img_url))
        });

    picturesByCategoryList.addAll(res);
  }

  Future<void> selectSubCategory(int categoryIdx) async {
    List<SubCategoryDTO>? result =
        await apiService.selectSubCategory(categoryIdx);
    List<SubCategoryVO> res = [];

    result?.map((e) =>
        {res.add(SubCategoryVO(e.sub_category_idx, e.sub_category_name))});

    subCategoryList.addAll(res);
  }
}
