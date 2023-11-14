import 'package:grip/api/ApiService.dart';
import 'package:grip/model/pair.dart';
import 'package:grip/model/premium_model.dart';
import 'package:grip/model/sub_category_model.dart';
import 'package:grip/screen/home/dto/dto_picture_by_category.dart';
import 'package:grip/screen/home/dto/dto_sub_category.dart';
import 'package:grip/screen/home/vo/vo_event.dart';
import 'package:grip/screen/home/vo/vo_pictures_by_category.dart';
import 'package:grip/screen/home/vo/vo_sub_category.dart';
import 'package:grip/screen/home/vo/vo_wedding.dart';
import 'package:grip/screen/myinfo/widget/review/dto/dto_wrote_review.dart';
import 'package:grip/screen/myinfo/widget/review/vo/vo_wrote_review.dart';

import '../../model/review_model.dart';
import 'dto/dto_wedding.dart';

class HomeViewModel {
  final ApiService apiService = ApiService();

  Map<int, String>? categoryMap;
  Map<int, List<Pair<int, String>>>? subCategoryMap;
  int eventLength = 0;

  Future<List<PremiumModel>?> selectPremiumModel(int accountIdx) async {
    List<PremiumModel> list = await apiService.selectPremium(accountIdx) ?? [];

    return list;
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
    eventLength = list.length;
    return list;
  }

  Future<List<ReviewModel>> selectReview() async {
    List<ReviewModel> reviewList = await apiService.selectReview() ?? [];
    return reviewList;
  }

  Future<WroteReviewVO?> selectOneWroteReview(int reviewIdx) async {
    WroteReviewDto? model = await apiService.selectOneWroteReview(reviewIdx);
    if (model != null) {
      return WroteReviewVO(
        model.content_idx,
        model.review_idx,
        model.content_title,
        model.content_description,
        model.content_img_url,
        model.review_title,
        model.review_description,
        model.review_img_url,
        model.account_name,
        model.review_createtime,
      );
    }

    return null;
  }

  Future<List<WeddingVO>> selectWeddingPhoto() async {
    print("selectWeddingPhoto1");
    List<WeddingDTO> result = await apiService.selectWeddingPhoto() ?? [];
    print("selectWeddingPhoto2");
    List<WeddingVO> res = [];
    for (var model in result) {
      res.add(WeddingVO(
          model.content_idx, model.content_title, model.content_img_url));
    }
    return res;
  }

  Future<List<WeddingVO>> selectHotSpace() async {
    List<WeddingDTO> result = await apiService.selectHotSpace() ?? [];
    List<WeddingVO> res = [];
    for (var model in result) {
      res.add(WeddingVO(
          model.content_idx, model.content_title, model.content_img_url));
    }

    return res;
  }

  Future<List<WeddingVO>> selectPicturesByCategory(int categoryIdx) async {
    print("selectPicturesByCategory");
    List<WeddingDTO> result =
        await apiService.selectPicturesByCategory(categoryIdx) ?? [];
    List<WeddingVO> res = [];
    for (var model in result) {
      res.add(WeddingVO(
          model.content_idx, model.content_title, model.content_img_url));
    }
    return res;
  }

  Future<List<SubCategoryVO>> selectSubCategory(int categoryIdx) async {
    List<SubCategoryDTO> result =
        await apiService.selectSubCategory(categoryIdx) ?? [];
    List<SubCategoryVO> res = [];

    for (var model in result) {
      res.add(SubCategoryVO(model.sub_category_idx, model.sub_category_name));
    }

    return res;
  }

  Future<List<WeddingVO>> selectFindModel() async {
    List<WeddingDTO> result = await apiService.selectFindModel() ?? [];
    List<WeddingVO> res = [];

    for (var model in result) {
      res.add(WeddingVO(
          model.content_idx, model.content_title, model.content_img_url));
    }
    return res;
  }

  Future<void> selectCategory() async {
    List<SubCategoryModel>? list = await apiService.selectCategory();
    if (list != null) {
      categoryMap = <int, String>{};
      subCategoryMap = <int, List<Pair<int, String>>>{};

      for (int i = 0; i < list.length; i++) {
        categoryMap?[list[i].category_idx] = list[i].category_name;
      }

      for (var entry in categoryMap!.entries) {
        subCategoryMap?[entry.key] = [];
        for (int i = 0; i < list.length; i++) {
          if (entry.key == list[i].category_idx) {
            subCategoryMap![entry.key]!
                .add(Pair(list[i].sub_category_idx, list[i].sub_category_name));
          }
        }
      }
    }
  }
}
