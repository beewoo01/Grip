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
    return list;
  }

  Future<List<ReviewModel>> selectReview() async {
    List<ReviewModel> reviewList = await apiService.selectReview() ?? [];
    return reviewList;
    }

  Future<List<WeddingVO>> selectWeddingPhoto() async {
    List<WeddingDTO> result = await apiService.selectWeddingPhoto() ?? [];
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
    for(var model in result) {
      res.add(WeddingVO(model.content_idx, model.content_title, model.content_img_url));
    }

    return res;
  }


  Future<List<WeddingVO>> selectPicturesByCategory(int categoryIdx) async {
    print("selectPicturesByCategory");
    List<WeddingDTO> result =
        await apiService.selectPicturesByCategory(categoryIdx) ?? [];
    List<WeddingVO> res = [];
    for(var model in result) {
      res.add(WeddingVO(model.content_idx, model.content_title, model.content_img_url));
    }
    return res;
  }

  Future<List<SubCategoryVO>> selectSubCategory(int categoryIdx) async {
    List<SubCategoryDTO> result = await apiService.selectSubCategory(categoryIdx) ?? [];
    List<SubCategoryVO> res = [];

    for(var model in result) {
      res.add(SubCategoryVO(model.sub_category_idx, model.sub_category_name));
    }

    return res;
  }



  Future<List<WeddingVO>> selectFindModel() async {

    List<WeddingDTO> result = await apiService.selectFindModel() ?? [];
    List<WeddingVO> res = [];

    for (var model in result) {
      res.add(WeddingVO(model.content_idx, model.content_title, model.content_img_url));
    }
    return res;
  }
}
