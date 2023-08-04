import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/main.dart';
import 'package:grip/util/util.dart';

import 'reservation.dart';

class SpaceRentalDetail extends StatefulWidget {
  const SpaceRentalDetail({super.key});

  static const String route = '/promotion/detail';

  @override
  State<StatefulWidget> createState() => SpaceRentalDetailState();
}

class SpaceRentalDetailState extends State<SpaceRentalDetail> {
  final PageController _pageController = PageController(initialPage: 0);
  final PageController _pageController2 =
      PageController(viewportFraction: 0.5, keepPage: true);
  int pageViewLength = 2;
  List pages = [];

  @override
  void initState() {
    super.initState();
    pages = generatePages();
  }

  @override
  Widget build(BuildContext context) {
    final pages2 = List.generate(
        6,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: SizedBox(
                height: 100,
                child: Center(
                    child: Text(
                  "Page $index",
                  style: const TextStyle(color: Colors.indigo),
                )),
              ),
            ));

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12, left: 10),
                  child: Text(
                    '카테고리 > 공간대여 > 000스튜디오',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              buildDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: buildPageView(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    physics: const PageScrollPhysics(), // PageScrollPhysics 사용
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: index % 2 == 0 ? Colors.blue : Colors.green,
                          alignment: Alignment.center,
                          child: Text(
                            'Page $index',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '000스튜디오',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Row(
                            children: [
                              ImageIcon(
                                AssetImage('assets/images/noimage.png'),
                                color: Color(0xFF3A5A98),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  '제주특별자치도 제주시 00로 123',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: HexColor.fromHex('#BEBEBE'),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text('기타 상세 내용'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ImageIcon(
                                AssetImage('assets/images/noimage.png'),
                                color: Color(0xFF3A5A98),
                              ),
                              Text('찜하기')
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: buildDivider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: SizedBox(
                          width: 150,
                          child: OutlinedButton(
                            onPressed: () {
                              navigate(context, Reservation.route, isRootNavigator: false);
                            },
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                side: const BorderSide(
                                    color: Colors.black, width: 0.8)),
                            child: const Text(
                              '예약하기',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: buildDivider(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            '브랜드 소개글',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Container(
                            width: 1,
                            height: 100,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            '브랜드 소개에 관한\n내용을 작성해 주세요',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    )),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    '촬영 상품 설명',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              buildProductDescription(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 30),
                                child: buildDivider(),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  '오시는 길',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: HexColor.fromHex('#BEBEBE'),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: const Text(
                                    '00시 00구 00동 0000',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: 250,
                                  height: 250,
                                  color: HexColor.fromHex('#BEBEBE'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                                child: buildDivider(),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 100))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget buildProductDescription() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          )),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '상품에 대한 내용을 작성해 주세요',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                '텍스트 공간',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Container(
              width: 200,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        '1. 상품설명',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        '2. 판매자 개인의 규정 작성',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> generatePages() {
    return List.generate(
        6,
        (index) => GestureDetector(
              onTap: () {
                //navigate(context, PromotionDetail.route, isRootNavigator: false, arguments: {'index' : index});
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.pink,
                ),
                child: Container(
                  color: Colors.grey,
                  height: 200,
                  child: Center(
                      child: Text(
                    "Pag1bree $index",
                    style: const TextStyle(color: Colors.indigo),
                  )),
                ),
              ),
            ));
  }

  Divider buildDivider() {
    return const Divider(
      thickness: 1,
      height: 1,
      color: Colors.black,
    );
  }

  Widget buildPageView() {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: PageView.builder(
        itemBuilder: (_, index) {
          return pages[index % pages.length];
        },
        controller: _pageController,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        SizedBox(
          width: 30,
          height: 30,
          child: SvgPicture.asset('assets/images/category.svg'),
        )

        /*IconButton(
          icon: Image.asset('assets/images/setting_icon.png'),
          */ /*icon: const Icon(
            Icons.settings,
            color: Colors.black,
          ),*/ /*
          onPressed: () {},
        )*/
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Divider(
          thickness: 1,
          height: 1,
          color: Colors.black,
        ),
      ),
    );
  }
}
