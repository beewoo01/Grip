import 'package:flutter/cupertino.dart';
import 'package:grip/api/ApiService.dart';
import 'package:grip/model/content_model.dart';

import '../../model/pair.dart';
import '../../model/sub_category_model.dart';


class CategoryViewModel {
  final ApiService apiService = ApiService();

  Map<int, String>? categoryMap;
  Map<int, List<Pair<int, String>>>? subCategoryMap;
  List<ContentModel>? premiumContentList;
  List<ContentModel>? contentList;

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

  Future<List<ContentModel>?> selectContent(int subCategoryIdx) async {
    print(' selectContent');
    print(' categoryIdx is $subCategoryIdx');
    premiumContentList = [];
    contentList = [];
    List<ContentModel>? list = await apiService.selectContent(subCategoryIdx);
    print('selectContent $list');
    contentList = list;
    if (list != null) {
      for (var model in list) {
        if (model.content_ispro == 1) {
          premiumContentList!.add(model);
        }
      }
    }

    return list;
  }
}