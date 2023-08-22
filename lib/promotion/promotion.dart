import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:grip/promotion/promotion_detail.dart';

class Promotion extends StatelessWidget {
  const Promotion({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(),
        child: Navigator(
          key: promotionKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const PromotionSfw();
                break;

              case PromotionDetail.route:
                builder = (BuildContext _) {
                  final index = (settings.arguments as Map)['index'];
                  return PromotionDetail(index: index);
                };
                break;

              default:
                builder = (BuildContext _) => const PromotionSfw();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ));
  }
}

class PromotionSfw extends StatefulWidget {
  const PromotionSfw({super.key});

  @override
  State createState() => PromotionState();
}

class PromotionState extends State<PromotionSfw> {
  final PageController _pageController = PageController();
  int promotionListLength = 2;
  List pages = [];

  List<Widget> generatePages() {
    return List.generate(
        6,
        (index) => GestureDetector(
              onTap: () {
                navigate(context, PromotionDetail.route,
                    isRootNavigator: false, arguments: {'index': index});
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade300,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: SizedBox(
                  height: 280,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.shade300,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/writer/작가$index.jpg',
                          fit: BoxFit.fill,
                        ),
                      )

                      /*Text(
                    "Page $index",
                    style: const TextStyle(color: Colors.indigo),
                  )*/
                      ),
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
    return Scaffold(
      appBar: buildAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: buildPageView(),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: Divider(
                    thickness: 2,
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                child: buildContainer(index),
              ),
            );
          }, childCount: promotionListLength)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    promotionListLength = promotionListLength + 4;
                  });
                },
                child: const Text(
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
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 50),
              child: SizedBox(
                width: double.infinity,
                height: 250,
                child: buildHorizontalListView(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHorizontalListView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int position) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: 150,
              height: 200,
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    color: Colors.red,
                    child: Image.asset(
                      'assets/images/writer/작가$position.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Text('000 작가',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  const Center(
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

  Widget buildContainer(int index) {
    return Column(
      children: [
        Container(
          color: Colors.grey,
          width: double.infinity,
          height: 200,
          child: Image.asset(
            'assets/images/writer/작가$index.jpg',
            fit: BoxFit.fill,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        const Text(
          '000 작가',
          style: TextStyle(fontSize: 15),
        ),
        const Text(
          '주소를 입력해주세요',
          style: TextStyle(fontSize: 12),
        ),
        const Text(
          '5월 가정의 달 맞이',
          style: TextStyle(fontSize: 12),
        ),
        const Text(
          '가족 사진 촬영 할인 (기본 4인)',
          style: TextStyle(fontSize: 12),
        ),
      ],
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
            child: SizedBox(
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
              child: SmoothPageIndicator(
                controller: _pageController,
                count: pages.length,
                effect: const WormEffect(
                    dotHeight: 4, dotWidth: 4, type: WormType.thinUnderground),
              ),
            ))
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Divider(
            thickness: 1,
            height: 1,
            color: Colors.black,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
                flex: 7,
                child: Text(
                  '프로모션',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )),
            Expanded(
                flex: 3,
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        '000님',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: SvgPicture.asset('assets/images/category.svg'),
                        onPressed: () {
                          //Navigator.pop(context);
                          //Community Write에서 pop을 시키니 여기에서 pop한거와 동일하게 작동함
                        },
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
