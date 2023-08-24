import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grip/category/reservation.dart';
import 'package:grip/category/space_rental_detail.dart';
import 'package:provider/provider.dart';
import 'category/category_viewmodel.dart';
import 'category_watch.dart';
import 'package:grip/main.dart';

import 'model/pair.dart';

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
                  final title = (settings.arguments as Map)['title'];
                  final list = (settings.arguments as Map)['list'];

                  return CategoryWatch(
                    categoryIdx: idx,
                    categoryName: title,
                    categoryList: list,
                  );
                };
                break;

              case SpaceRentalDetail.route:
                builder = (BuildContext _) {
                  return const SpaceRentalDetail();
                };
                break;

              case Reservation.route:
                builder = (BuildContext _) {
                  return const Reservation();
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
          if (snapShot.hasData) {
            print('snapShot.hasData');
            return buildAppScaffold();
          } else if (snapShot.hasError) {
            print('snapShot.hasError');
            return buildNoDataAppScaffold();
          } else {
            print('snapShot. else ');
          }

          return buildNoDataAppScaffold();
        });
  }

  Scaffold buildAppScaffold() {
    Map<int, String>? map = categoryViewModel.categoryMap;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i in map!.keys)
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                //child: buildBox(map[i]!, true, snapList),
                //child: buildBox(map[i]!, true, modelList),

                child: buildBox(
                    i, map[i]!, true, categoryViewModel.subCategoryMap![i]!),
              )
          ],
        ),
      ),
    );
  }

  Scaffold buildNoDataAppScaffold() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildBox(1, '스냅촬영', true, []),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildBox(2, '영상촬영', false, []),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildBox(3, '모델', false, []),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildBox(4, '공간대여', false, []),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          '모든 카테고리',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ));
  }

  Widget buildBox(
      int idx, String title, bool isShowAllWatchButton, List<Pair<int, String>> list) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 235, 235, 235)),
          color: const Color.fromARGB(255, 235, 235, 235)),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextButton(
                    onPressed: () {
                      navigate(context, CategoryWatch.route,
                          isRootNavigator: false,
                          arguments: {'idx': idx,'title': title, 'list': list});
                    },
                    child: const Text(
                      '전체보기',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ),
          Column(children: [
            if (list.length % 3 == 0) ...[
              for (int i = 0; i < (list.length / 3); i++) ...[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 20, right: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int j = i * 3; j < (i * 3 + 3); j++) ...[
                        if (j < list.length) ...[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.transparent,
                                //color: const Color.fromARGB(255, 235, 235, 235)
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                list[j].secend,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                        ]
                      ]
                    ],
                  ),
                ),
              ]
            ] else ...[
              for (int i = 0; i < (list.length / 3) + 1; i++) ...[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 20, right: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int j = i * 3; j < (i * 3 + 3); j++) ...[
                        if (j < list.length) ...[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        255, 235, 235, 235)),
                                color: Colors.transparent),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                list[j].secend,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                          //Text('This is not /3')
                        ]
                      ]
                    ],
                  ),
                ),
              ]
            ],
            const Padding(padding: EdgeInsets.only(bottom: 20)),
          ]),
        ],
      ),
    );
  }
}
