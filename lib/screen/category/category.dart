import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_loading.dart';
import 'package:grip/screen/category/reservation.dart';
import 'package:grip/screen/category/content_detail.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../model/pair.dart';
import 'category_viewmodel.dart';
import 'category_watch.dart';
import 'package:grip/main.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(),
        child: Navigator(
          key: categoryKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const CategoryStf();
                break;

              case CategoryWatch.route:
                builder = (BuildContext _) {
                  final idx = (settings.arguments as Map)['idx'];
                  final subIdx = (settings.arguments as Map)['subIdx'];
                  final title = (settings.arguments as Map)['title'];
                  final list = (settings.arguments as Map)['list'];
                  return CategoryWatch(
                    categoryIdx: idx,
                    subCategoryIdx: subIdx,
                    categoryName: title,
                    categoryList: list,
                  );
                };
                break;

              case ContentDetail.route:
                builder = (BuildContext _) {
                  final root = (settings.arguments as Map)['root'];
                  final idx = (settings.arguments as Map)['content_idx'];
                  return ContentDetail(
                    path: '$root',
                    contentIdx: idx,
                  );
                };
                break;

              case Reservation.route:
                builder = (BuildContext _) {
                  final contentIdx = (settings.arguments as Map)['content_idx'];
                  return Reservation(contentIdx: contentIdx);
                };
                break;

              default:
                builder = (BuildContext _) => const CategoryStf();
            }

            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ));
  }
}

class CategoryStf extends StatefulWidget {
  const CategoryStf({super.key});

  @override
  State createState() => CategoryState();
}

class CategoryState extends State<CategoryStf> {
  CategoryViewModel categoryViewModel = CategoryViewModel();

  @override
  Widget build(BuildContext context) {
    //categoryViewModel.selectCategory();

    return FutureBuilder(
        future: categoryViewModel.selectCategory(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          if (snapShot.hasData) {
            return buildAppScaffold();
          }

          return buildNoDataAppScaffold();
        });
  }

  Scaffold buildAppScaffold() {
    Map<int, String>? map = categoryViewModel.categoryMap;
    //int a = categoryViewModel.subCategoryMap![0]!.first.first;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i in map!.keys)
              buildBox(i, map[i]!, true, categoryViewModel.subCategoryMap![i]!)
                  .pSymmetric(v: 10),
            const Height(60)
          ],
        ),
      ),
    );
  }

  Scaffold buildNoDataAppScaffold() {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildBox(1, '스냅촬영', true, []).pSymmetric(v: 10),
            buildBox(2, '영상촬영', false, []).pSymmetric(v: 10),
            buildBox(3, '모델', false, []).pSymmetric(v: 10),
            buildBox(4, '공간대여', false, []).pSymmetric(v: 10),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: const Text(
          '모든 카테고리',
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ));
  }

  Widget buildBox(int idx, String title, bool isShowAllWatchButton,
      List<Pair<int, String>> list) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: AppColors.grey),
          color: AppColors.grey),
      child: Column(
        children: [
          height20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title.text.bold.size(15).make(),
              GestureDetector(
                  onTap: () {
                    navigate(context, CategoryWatch.route,
                        isRootNavigator: false,
                        arguments: {
                          'idx': idx,
                          'subIdx': list.first.first,
                          'title': title,
                          'list': list
                        });
                  },
                  child: '전체보기'.text.color(AppColors.black).make())
            ],
          ).pSymmetric(v: 5, h: 20),
          height10,
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 1,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
            ),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                int subIdx = list[index].first;
                navigate(context, CategoryWatch.route,
                    isRootNavigator: false,
                    arguments: {
                      'idx': idx,
                      'subIdx': subIdx,
                      'title': title,
                      'list': list
                    });
              },
              child: Container(
                alignment: index == 0 || index == 3 ? Alignment.centerLeft : index == 1 || index == 4? Alignment.center :Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.transparent,
                  ),
                ),
                child: list[index]
                    .secend
                    .text
                    .color(AppColors.black)
                    .make()
                    .pSymmetric(h: 5),
              ),
            ),
            itemCount: list.length,
            shrinkWrap: true,
          ).pSymmetric(h: 20),
          height20
          /*if (list.length % 3 == 0) ...[
            for (int i = 0; i < (list.length / 3); i++) ...[
              height5,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int j = i * 3; j < (i * 3 + 3); j++) ...[
                    if (j < list.length) ...[
                      GestureDetector(
                        onTap: (){
                          int subIdx = list[j].first;
                          navigate(context, CategoryWatch.route,
                              isRootNavigator: false,
                              arguments: {
                                'idx': idx,
                                'subIdx': subIdx,
                                'title': title,
                                'list': list
                              });
                        },
                        child: Container(
                          alignment: j == 0 || j == 3 ? Alignment.centerLeft : j == 1 || j == 4? Alignment.center :Alignment.centerRight,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.transparent,
                              //color: const Color.fromARGB(255, 235, 235, 235)
                            ),
                          ),
                          child: list[j].secend.text
                              .color(AppColors.black)
                              .make()
                              .pSymmetric(h: 5),
                        ),
                      )
                    ]
                  ]
                ],
              ).pSymmetric(h: 20),
              height10,
            ]
          ] else ...[
            for (int i = 0; i < (list.length / 3) + 1; i++) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int j = i * 3; j < (i * 3 + 3); j++) ...[
                    if (j < list.length) ...[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: AppColors.transparent),
                            color: Colors.transparent),
                        child: list[j]
                            .secend
                            .text
                            .color(AppColors.black)
                            .make()
                            .pSymmetric(h: 5),
                      )
                    ]
                  ]
                ],
              ).pOnly(top: 5, left: 20, right: 20, bottom: 10),
            ]
          ],
          height20,*/
        ],
      ),
    );
  }
}
