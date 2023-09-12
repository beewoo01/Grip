import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/main.dart';
import 'package:grip/model/pair.dart';
import 'package:grip/screen/category/category_primium_wide.dart';
import 'package:grip/screen/category/content_detail.dart';

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
  State createState() => CategoryWatchState(categoryIdx, subCategoryIdx, categoryName);

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
    return FutureBuilder(
        future: viewModel.selectContent(subCategoryIdx),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return buildAppScaffold(categoryIdx);
          } else if (snapShot.hasError) {
            print('${snapShot.error}');
            return buildNoDataAppScaffold('데이터 조회 중 에러가 발생했습니다.');
          } else {
            return buildNoDataAppScaffold('');
          }
        });
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: CustomScrollView(
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
                  viewModel: viewModel,
                ),
              ),
            ),
            Container(
              child: isOdd ? buildCategoryGrid() : buildCategoryList(),
            )
          ],
        ),
      ),
    );
  }

  SliverList buildCategoryList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: GestureDetector(
              onTap: () {
                navigate(context, ContentDetail.route,
                    isRootNavigator: false,
                    arguments: {
                      'root':
                          '$categoryName > ${viewModel.contentList![index].content_title}',
                      'content_idx': viewModel.contentList![index].content_idx
                    });
              },
              child: Container(
                width: 300,
                height: 270,
                decoration:
                    const BoxDecoration(color: AppColors.white, boxShadow: [
                  BoxShadow(
                      color: AppColors.black,
                      offset: Offset(1, 1),
                      blurRadius: 0.1,
                      spreadRadius: 0.0)
                ]),
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Container(
                                width: double.infinity,
                                height: 200,
                                color: AppColors.grey,
                                child: Image.asset(
                                  'assets/images/movie/$index.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Center(
                                child: Text(viewModel
                                    .contentList![index].content_title),
                              ),
                            )
                          ],
                        )),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/images/heart.svg')),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        childCount: viewModel.contentList?.length,
      ),
    );
  }

  SliverGrid buildCategoryGrid() {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: GestureDetector(
              onTap: () {
                navigate(context, ContentDetail.route,
                    isRootNavigator: false,
                    arguments: {
                      'root':
                          '$categoryName > ${viewModel.contentList![index].content_title}',
                      'content_idx': viewModel.contentList![index].content_idx
                    });
              },
              child: Container(
                color: AppColors.white,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.black,
                                    offset: Offset(1, 1),
                                    blurRadius: 0.1,
                                    spreadRadius: 0.0)
                              ]),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 5),
                                    child: Container(
                                      color: AppColors.grey,
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: double.infinity,
                                    color: AppColors.white,
                                    child: Center(
                                      child: Text(viewModel
                                          .contentList![index].content_title),
                                    ),
                                  ))
                            ],
                          ),
                        )),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/images/category.svg'),
                        ))
                  ],
                ),
              ),
            ),
          );
        }, childCount: viewModel.contentList!.length),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2));
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
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedPosition = index;
                          viewModel.selectContent(list[index].first);
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
                      )))
              //Text(list[index]),
              );
        });
  }
}