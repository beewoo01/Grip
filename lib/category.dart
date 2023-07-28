import 'package:flutter/material.dart';
import 'category_watch.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State createState() => CategoryState();
}

class CategoryState extends State<Category> {
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
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: buildBox('스냅촬영', true, snapList),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: buildBox('영상촬영', false, videoList),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: buildBox('모델', false, modelList),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: buildBox('공간대여', false, spaceList),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBox(String title, bool isShowAllWatchButton, List<String> list) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(width: 1, color: Color.fromARGB(255, 235, 235, 235)),
          color: Color.fromARGB(255, 235, 235, 235)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CategoryWatch(title, list)));
                    },
                    child: Text(
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
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int j = i * 3; j < (i * 3 + 3); j++) ...[
                        if (j < list.length) ...[
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text(list[j]),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(255, 235, 235, 235)),
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
                  padding:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int j = i * 3; j < (i * 3 + 3); j++) ...[
                        if (j < list.length) ...[
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text(list[j]),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(255, 235, 235, 235)),
                                color: Colors.black),
                          )
                          //Text('This is not /3')
                        ]
                      ]
                    ],
                  ),
                ),
              ]
            ],
            Padding(padding: EdgeInsets.only(bottom: 20)),
          ]),
        ],
      ),
    );
  }
}
