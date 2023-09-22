import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/main.dart';
import 'package:grip/model/pair.dart';
import 'package:grip/screen/category/category_primium_wide.dart';
import 'package:grip/screen/category/content_detail.dart';
import 'package:grip/screen/category/widget/w_grid_category.dart';
import 'package:grip/screen/category/widget/w_list_category.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import 'category_viewmodel.dart';

class CategoryWatch extends StatefulWidget {
  final int categoryIdx;
  final int subCategoryIdx;
  final String categoryName;
  final List<Pair<int, String>> categoryList;

  const CategoryWatch(
      {Key? key,
      required this.categoryIdx,
      required this.subCategoryIdx,
      required this.categoryName,
      required this.categoryList})
      : super(key: key);

  static const String route = '/category/watch/detail';

  @override
  State createState() =>
      CategoryWatchState(categoryIdx, subCategoryIdx, categoryName);
}

class CategoryWatchState extends State<CategoryWatch> {
  CategoryViewModel viewModel = CategoryViewModel();
  int categoryIdx;
  int subCategoryIdx;
  String categoryName;
  int selectedPosition = 0;

  CategoryWatchState(this.categoryIdx, this.subCategoryIdx, this.categoryName);

  @override
  Widget build(BuildContext context) {
    print('CategoryWatchState $subCategoryIdx');
    return buildAppScaffold(categoryIdx);
  }

  Scaffold buildNoDataAppScaffold(String massage) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: createToolbar(widget.categoryName),
      body: Center(
        child: Text(
          massage,
          style: const TextStyle(color: AppColors.black),
        ),
      ),
    );
  }

  Scaffold buildAppScaffold(int idx) {
    bool isOdd = idx.isOdd;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: createToolbar(widget.categoryName),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: buildHorizontalCategory(widget.categoryList),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: 370,
              child: CategoryWideBody(
                widget.categoryName,
                viewModel: viewModel,
              ),
            ),
          ),
          FutureBuilder(
              future: viewModel.selectContent(
                  subCategoryIdx, Singleton().getAccountIdx()),
              builder: (builder, snapShot) {
                return Container(
                  //child: isOdd ? buildCategoryGrid() : buildCategoryList(),
                  child: isOdd
                      ? GridCategoryWidget(viewModel, categoryName)
                      : CategoryListWidget(viewModel, categoryName),
                );
              })
        ],
      ).pOnly(bottom: 60),
    );
  }

  AppBar createToolbar(String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.black,
          )),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.black),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/images/category.svg')),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: AppColors.black,
          height: 1.0,
        ),
      ),
    );
  }

  Widget buildHorizontalCategory(List<Pair<int, String>> list) {
    //Singleton().setAccountIdx(2);
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Center(
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedPosition = index;
                      viewModel.selectContent(
                          list[index].first, Singleton().getAccountIdx());
                      subCategoryIdx = list[index].first;
                    });
                    //onCategoryButtonClicked(false);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: selectedPosition == index
                          ? AppColors.black
                          : Colors.transparent),
                  child: Text(
                    list[index].secend,
                    style: TextStyle(
                        color: selectedPosition == index
                            ? AppColors.white
                            : AppColors.black),
                  ))).pSymmetric(h: 8);
        });
  }
}
