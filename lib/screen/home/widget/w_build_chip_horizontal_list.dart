import 'package:flutter/material.dart';
import 'package:grip/main.dart';
import 'package:grip/model/pair.dart';
import 'package:grip/screen/category/category_watch.dart';
import 'package:grip/screen/home/vm_home.dart';
import 'package:grip/screen/home/widget/w_chip_horizontal_list.dart';

class BuildChipHorizontalList extends StatelessWidget {
  final HomeViewModel viewModel;
  final int categoryIdx;
  final height = 30.0;

  const BuildChipHorizontalList(
      {super.key,
      required this.viewModel,
      required this.categoryIdx});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: height,
        child: ChipHorizontalList(
          viewModel,
          categoryIdx,
          callback: (categoryIdx, subCategoryIdx, categoryName) {
            navigate(context, CategoryWatch.route,
                isRootNavigator: false,
                arguments: {
                  'idx': categoryIdx,
                  'subIdx': subCategoryIdx,
                  'title': categoryName,
                  'list': viewModel.subCategoryMap?[categoryIdx]
                  //여기
                });
          },
        ));
  }
}
