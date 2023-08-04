import 'package:flutter/material.dart';
import 'package:grip/category/reservation.dart';
import 'package:grip/category/space_rental_detail.dart';
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
                  print('title');
                  final title = (settings.arguments as Map)['title'];
                  print(title);
                  final list = (settings.arguments as Map)['list'];

                  return CategoryWatch(title : title, categoryList : list);
                };
                break;

              case SpaceRentalDetail.route :
                builder = (BuildContext _) {
                  return const SpaceRentalDetail();
                };
                break;

              case Reservation.route :
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
  List<String> snapList = [
    '웨딩작가',
    '스냅작가',
    '바디프로필',
    '유아프로필',
    '애견프로필',
    '건축&인테리어',
    // '셀프사진관',
  ];

  List<String> videoList = [
    '광고,홍보영상',
    '제품영상',
    '온라인 중계',
    '행사영상',
    '유튜브 영상',
    '애니메이션'
  ];

  List<String> modelList = ['뷰티', '시니어 패션', '일반인', '손', 'mc . 공연', 'CF광고'];

  List<String> spaceList = [
    '카페/식당',
    '주택/아파트',
    '자연광스튜디오',
    '호리존스튜디오',
    '복합문화 공간',
    '갤러리'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildBox('스냅촬영', true, snapList),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildBox('영상촬영', false, videoList),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildBox('모델', false, modelList),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildBox('공간대여', false, spaceList),
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

  Widget buildBox(String title, bool isShowAllWatchButton, List<String> list) {
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
                          arguments: {'title': title, 'list': list});
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
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(list[j]),
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
                                color: Colors.black),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Text(list[j]),
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
