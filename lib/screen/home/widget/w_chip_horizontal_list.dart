import 'package:flutter/material.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_separator_container.dart';
import 'package:grip/screen/home/vm_home.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/color/AppColors.dart';

class ChipHorizontalList extends StatelessWidget {
  final HomeViewModel viewModel;
  final int categoryIdx;

  const ChipHorizontalList(this.viewModel, this.categoryIdx, {super.key});

  @override
  Widget build(BuildContext context) {
    print("ChipHorizontalList build");
    return FutureBuilder(
        future: viewModel.selectSubCategory(categoryIdx),
        builder: (builder, snapShot) {
          if (snapShot.hasData == false) {
            return height30;
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              return Center(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.black),
                    child: snapShot.data?[index].sub_category_name.text
                        .color(AppColors.white)
                        .make()
                        .pSymmetric(h: 10, v: 6)),
              );
            },
            separatorBuilder: (context, index) => separator10,
            itemCount: snapShot.data?.length ?? 0,
            scrollDirection: Axis.horizontal,
          );
        });
  }
}
