import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:grip/promotion/promotion_detail.dart';

class Promotion extends StatefulWidget {

  @override
  State createState() => PromotionState();
}

class PromotionState extends State<Promotion> {
  PageController _pageController = PageController();
  int promotionListLength = 2;
  List pages = [];
  List<Widget> generatePages() {
    return List.generate(
        6,
        (index) => GestureDetector(
              onTap: () {
                //print('index $index');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PromotionDetail(index)));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade300,
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Container(
                  height: 280,
                  child: Center(
                      child: Text(
                    "Page $index",
                    style: TextStyle(color: Colors.indigo),
                  )),
                ),
              ),
            ));
  }




  @override
  void initState() {
    super.initState();
    pages = generatePages();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: buildPageView(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                    child: Divider(
                      thickness: 2,
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )),
        ),
        SliverList(
            delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  child: buildContainer(),
                ),
              );
            }, childCount: promotionListLength)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: TextButton(
              onPressed: () {
                setState(() {
                  promotionListLength = promotionListLength + 4;
                });
              },
              child: Text(
                'Read More',
                style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Container(
              width: double.infinity,
              height: 250,
              child: buildHorizontalListView(),
            ),
          ),
        )
      ],
    );
  }

  Widget buildHorizontalListView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int position) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              width: 150,
              height: 200,
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.grey,
                  ),
                  Text('000 작가',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Center(
                    child: Text(
                      '5월 가정의 달 맞이 \n가족사진 촬영 할인',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildContainer() {
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            width: double.infinity,
            height: 200,
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          Text(
            '000 작가',
            style: TextStyle(fontSize: 15),
          ),
          Text(
            '주소를 입력해주세요',
            style: TextStyle(fontSize: 12),
          ),
          Text(
            '5월 가정의 달 맞이',
            style: TextStyle(fontSize: 12),
          ),
          Text(
            '가족 사진 촬영 할인 (기본 4인)',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget buildPageView() {
    return Stack(
      children: [
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 250,
              child: PageView.builder(
                  controller: _pageController,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  }),
            )),
        Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: pages.length,
                  effect: WormEffect(
                      dotHeight: 4,
                      dotWidth: 4,
                      type: WormType.thinUnderground),
                ),
              ),
            ))
      ],
    );
  }

  AppBar createToolbar(String title) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
        ));
  }
}
