import 'package:flutter/material.dart';
import 'package:grip/community/community_register.dart';
import 'package:grip/community/community_write.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State createState() => CommunitySfw();

}


class CommunitySfw extends State<Community> {
  bool isPhotoReview = true;
  Color photoBackgroundColor = Colors.black;
  Color photoTextColor = Colors.white;
  Color questionBackgroundColor = Colors.transparent;
  Color questionTextColor = Colors.black;

  @override
  void initState() {
    super.initState();
    print('_CommunitySfw initState');
  }

  @override
  void deactivate() {
    print('Community deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('Community dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_CommunitySfw');
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Column(
                children: [
                  //buildAppBar(),
                  buildDivider(2, 1),
                  Container(
                    width: double.infinity,
                    height: 100,
                    child: buildPhotoAndQuestion(),
                  ),
                  Container(
                    child: buildMiddleCategory(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                    child: buildDivider(1.5, 1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: buildBottomCategory(),
                  ),

                  Expanded(
                    child: buildCommunityList(),
                  )
                  //buildCommunityList()
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10, right: 10),
              child: buildFloatingActionButton(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black,
        child: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CommunityResister()));
                  //MaterialPageRoute(builder: (_) => CommunityWrite()));
            },
            icon: Icon(Icons.ac_unit)));
  }

  Widget buildCommunityList() {
    String category = '스냅촬영';
    String detailCategory = '웨딩작가';
    String writer = '000작가';
    String reviewContents =
        '리뷰 내용 입니다. 리뷰 내용입니다. 리뷰 내용입니다. 리뷰 내용 입니다. 리뷰 내용입니다. 리뷰 내용입니다. 리뷰 내용 입니다. 리뷰 내용입니다. 리뷰 내용입니다. ';
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (BuildContext context, int position) {
          return Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Container(
                width: double.infinity,
                height: 100,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                                width: double.infinity,
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        buildListText(
                                            '${category} * ${detailCategory}',
                                            10,
                                            FontWeight.bold,
                                            1),
                                        buildListText(
                                            '$writer', 14, FontWeight.bold, 1),
                                        Padding(
                                          padding: EdgeInsets.only(top: 1),
                                          child: buildListText(reviewContents,
                                              10, FontWeight.normal, 3),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            flex: 7,
                          ),
                          Flexible(
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            flex: 3,
                          ),
                        ],
                      ),
                    ),
                    buildDivider(1, 1)
                  ],
                )

                /**/
                ),
          );
        });
  }

  Widget buildListText(
      String text, double textSize, FontWeight fontWeight, int maxLines) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        style: TextStyle(fontSize: textSize, fontWeight: fontWeight),
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
      ),
    );
  }

  Widget buildBottomCategory() {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(right: 5),
              child: buildBottomCategoryItem(
                  Colors.black, Colors.white, Colors.black, '카테고리'),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: buildBottomCategoryItem(
                  Colors.black, Colors.black, Colors.white, '세부 카테고리'),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomCategoryItem(
      Color borderColor, Color textColor, Color boxColor, String text) {
    return Container(
      decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: borderColor, width: 1)),
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: FontWeight.normal),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3),
              child: Icon(
                Icons.check_circle_outline,
                size: 13.0,
                color: textColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Divider buildDivider(double thickness, double height) {
    return Divider(
      thickness: thickness,
      height: height,
      color: Colors.black,
    );
  }

  Widget buildPhotoAndQuestion() {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              onCategoryButtonClicked(true);
            },
            style: TextButton.styleFrom(backgroundColor: photoBackgroundColor),
            child: Text('사진리뷰', style: TextStyle(color: photoTextColor)),
          ),
          TextButton(
              onPressed: () {
                onCategoryButtonClicked(false);
              },
              style: TextButton.styleFrom(
                  backgroundColor: questionBackgroundColor),
              child: Text(
                '문의하기',
                style: TextStyle(color: questionTextColor),
              ))
        ],
      ),
    );
  }

  Widget buildMiddleCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: buildMiddleCategoryBox(0, '스냅촬영')),
        Expanded(child: buildMiddleCategoryBox(1, '영상촬영')),
        Expanded(child: buildMiddleCategoryBox(2, '모델')),
        Expanded(child: buildMiddleCategoryBox(3, '공간대여')),
      ],
    );
  }

  Widget buildMiddleCategoryBox(int position, String name) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey,
              )),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                )),
          )
        ],
      ),
    );
  }

  void onCategoryButtonClicked(bool isPhotoClick) {
    setState(() {
      if (isPhotoClick) {
        photoBackgroundColor = Colors.black;
        questionBackgroundColor = Colors.transparent;
        photoTextColor = Colors.white;
        questionTextColor = Colors.black;
      } else {
        photoBackgroundColor = Colors.transparent;
        questionBackgroundColor = Colors.black;
        photoTextColor = Colors.black;
        questionTextColor = Colors.white;
      }
    });
  }

  Widget buildCategory() {
    return Container();
  }

  /*AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  '커뮤니티',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                )),
            Expanded(flex: 6, child: Container()),
            Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ))
          ],
        ));
  }*/
}
