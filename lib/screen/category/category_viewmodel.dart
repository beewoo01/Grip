import 'package:flutter/cupertino.dart';
import 'package:grip/api/ApiService.dart';
import 'package:grip/model/content_model.dart';
import 'package:grip/screen/category/vo/vo_category_content.dart';

import '../../model/pair.dart';
import '../../model/sub_category_model.dart';
import 'dto/dto_category_content.dart';

class CategoryViewModel {
  final ApiService apiService = ApiService();

  Map<int, String>? categoryMap;
  Map<int, List<Pair<int, String>>>? subCategoryMap;
  List<CategoryContentVO> premiumContentList = [];
  List<CategoryContentVO> contentList = [];

  Future<List<SubCategoryModel>?> selectCategory() async {
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

      return list;
    }
  }

  Future<List<CategoryContentDTO>?> selectContent(int subCategoryIdx, int accountIdx) async {
    print(' selectContent');
    print(' selectContent categoryIdx is $subCategoryIdx');
    print(' selectContent accountIdx is $accountIdx');

    List<CategoryContentDTO> list =
        await apiService.selectCategoryContent(subCategoryIdx, accountIdx) ?? [];
    List<CategoryContentVO> res = [];
    List<CategoryContentVO> resPro = [];
    print('selectContent $list');
    for (var model in list) {
      res.add(CategoryContentVO(
         model.content_idx,
         model.content_title,
         model.content_description,
         model.content_img_url,
      ));

      if (model.content_ispro == 1) {
        resPro.add(CategoryContentVO(
            model.content_idx,
            model.content_title,
            model.content_description,
            model.content_img_url));
      }
    }
    premiumContentList.clear();
    contentList.clear();
    contentList.addAll(res);
    premiumContentList.addAll(resPro);

    for (var model in list) {}

    return list;
  }
}
