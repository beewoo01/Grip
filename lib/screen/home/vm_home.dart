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
  List<WeddingVO> picturesByCategoryList = [];
  List<SubCategoryVO> subCategoryList = [];
  List<WeddingVO> findModelList = [];

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

  Future<List<ReviewModel>> selectReview() async {
    List<ReviewModel> reviewList = await apiService.selectReview() ?? [];
    this.reviewList = reviewList;
    return reviewList;
    }

  Future<List<WeddingVO>> selectWeddingPhoto() async {
    List<WeddingDTO> result = await apiService.selectWeddingPhoto() ?? [];
    List<WeddingVO> res = [];
    weddingList.clear();
    print("selectWeddingPhoto result.length");
    print("selectWeddingPhoto ${result.length}");
    for (var model in result) {
      res.add(WeddingVO(
          model.content_idx, model.content_title, model.content_img_url));
    }

    print("selectWeddingPhoto res");
    print("${res.length}");
    weddingList.addAll(res);
    return weddingList;
  }

  Future<List<WeddingVO>> selectHotSpace() async {
    List<WeddingDTO> result = await apiService.selectHotSpace() ?? [];
    List<WeddingVO> res = [];
    for(var model in result) {
      res.add(WeddingVO(model.content_idx, model.content_title, model.content_img_url));
    }

    return res;
  }


  Future<List<WeddingVO>> selectPicturesByCategory(int categoryIdx) async {
    List<WeddingDTO> result =
        await apiService.selectPicturesByCategory(categoryIdx) ?? [];
    List<WeddingVO> res = [];
    for(var model in result) {
      res.add(WeddingVO(model.content_idx, model.content_title, model.content_img_url));
    }
    print("selectPicturesByCategory res");
    print(res.toString());
    print(res.length);
    picturesByCategoryList.addAll(res);
    return res;
  }

  Future<List<SubCategoryVO>> selectSubCategory(int categoryIdx) async {
    List<SubCategoryDTO> result = await apiService.selectSubCategory(categoryIdx) ?? [];
    List<SubCategoryVO> res = [];

    for(var model in result) {
      res.add(SubCategoryVO(model.sub_category_idx, model.sub_category_name));
    }

    subCategoryList.addAll(res);

    return res;
  }



  Future<List<WeddingVO>> selectFindModel() async {

    List<WeddingDTO> result = await apiService.selectFindModel() ?? [];
    print("selectFindModel");
    List<WeddingVO> res = [];
    findModelList.clear();

    for (var model in result) {
      res.add(WeddingVO(model.content_idx, model.content_title, model.content_img_url));
    }
    print("res ${res.length}");
    findModelList.addAll(res);
    print(findModelList.toString());

    return res;
  }
}
