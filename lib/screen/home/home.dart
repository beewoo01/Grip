import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_height_and_width.dart';

import 'package:grip/main.dart';
import 'package:grip/screen/home/vm_home.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/url/grip_url.dart';
//final homeKey = GlobalKey<NavigatorState>();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(),
        child: Navigator(
          key: homeKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const HomeSfw();
                break;
              /*case FeedDetail.route:
            builder = (BuildContext _) {
              final id = (settings.arguments as Map)['id'];
              return FeedDetail(
                feedId: id,
              );
            };
            break;*/
              default:
                builder = (BuildContext _) => const HomeSfw();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ));
  }
}

class HomeSfw extends StatefulWidget {
  const HomeSfw({super.key});

  @override
  State<HomeSfw> createState() => _HomeSfw();
}

class _HomeSfw extends State<HomeSfw> {
  final viewModel = HomeViewModel();

  final colorCodes = [400, 100, 300, 200, 100];
  final categoryData = ['웨딩촬영', '바프촬영', '모델', '공간대여'];

  @override
  void initState() {
    super.initState();
    if (Singleton().getAccountIdx() == null) {
      Singleton().setAccountIdx(2);
    }

    viewModel.selectPremiumModel(Singleton().getAccountIdx()!);
    viewModel.selectEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildPageView(),
            Container(
                width: double.infinity,
                color: AppColors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Column(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: 'GRIP 프리미엄 Pro'
                            .text
                            .color(AppColors.white)
                            .bold
                            .size(18)
                            .make()),
                    height10,
                    SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: buildPremiumList())
                        .pSymmetric(h: 5, v: 5),
                    height10
                  ],
                )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: buildCategoryGrid(),
            ),
            Container(
              width: double.infinity,
              height: 100,
              color: AppColors.grey,
              child: buildPromotionBanner(),
            ),
            buildListContainer('웨딩 사진 촬영', 'weding')
                .pOnly(top: 10, left: 10, right: 10),
            buildListContainer('최근 핫한 공간!!', 'studio')
                .pOnly(top: 10, left: 10, right: 10),
            buildChipListAndContentList(
                    '이달의 인기 스냅촬영',
                    [
                      '웨딩작가',
                      '스냅작가',
                      '바디프로필',
                      '유니버셜',
                      'flutter',
                      'android',
                      'ios'
                    ],
                    [
                      'image1',
                      'image2',
                      'image3',
                      'image4',
                    ],
                    200.0,
                    300.0,
                    'snap')
                .pOnly(top: 10, left: 10, right: 10),
            buildChipListAndContentList(
                    '이달의 인기 영상촬영',
                    [
                      '바이럴영상',
                      '제품영상',
                      '브랜드필름',
                      '유니버셜',
                      'flutter',
                      'android',
                      'ios'
                    ],
                    [
                      'image1',
                      'image2',
                      'image3',
                      'image4',
                    ],
                    250.0,
                    200.0,
                    'bodyprofile')
                .pOnly(top: 10, left: 10, right: 10),
            buildChipListAndContentList(
                    '우리가 찾는 모델',
                    ['뷰티모델', '시니어모델', '일반인', 'MTOM', 'SG워너비', 'V.O.S', '먼데이키즈'],
                    [
                      'image1',
                      'image2',
                      'image3',
                      'image4',
                    ],
                    250.0,
                    200.0,
                    'model')
                .pOnly(top: 10, left: 10, right: 10),
            buildChipListAndContentList(
                    '이달의 인기 공간',
                    ['스튜디오', '대형공간', '상영관', '영화관', '무대', '노래방', '술집'],
                    [
                      'image1',
                      'image2',
                      'image3',
                      'image4',
                    ],
                    250.0,
                    200.0,
                    'studio')
                .pOnly(top: 10, left: 10, right: 10),
            buildPhotoReview().pOnly(top: 10, left: 10, right: 10),
            buildFooter().pOnly(top: 10, left: 10, right: 10),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Divider(
            thickness: 1,
            height: 1,
            color: AppColors.black,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
                flex: 7,
                child: Text(
                  'GRIP',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black),
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
                            color: AppColors.black),
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

  Widget buildPageView() {
    return FutureBuilder(
        future: viewModel.selectEvent(),
        builder: (builder, context) {
          return Container(
              width: double.infinity,
              height: 400,
              color: AppColors.grey,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: PageView.builder(
                        controller: PageController(initialPage: 0),
                        itemCount: viewModel.eventList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: double.infinity,
                              height: 400,
                              color: AppColors.black,
                              child: context.buildImage(
                                viewModel.eventList[index].event_img_url,
                              )

                              /*CachedNetworkImage(
                                imageUrl:
                                "${GripUrl.imageUrl}${viewModel.eventList[index]
                                    .event_img_url}",
                                placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                                fit: BoxFit.fill,
                              )*/
                              );
                        }),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.chevron_left)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.chevron_right))
                      ],
                    ),
                  )
                ],
              ));
        });
  }

  Widget buildPremiumList() {
    return FutureBuilder(
        future: viewModel.selectPremiumModel(Singleton().getAccountIdx()!),
        builder: (builder, context) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final model = viewModel.premiumList?[index];
              if (model == null) {
                return Container();
              }
              return SizedBox(
                width: 200,
                height: 250,
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "${GripUrl.imageUrl}${model.content_img_url}",
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/noimage.png',
                                    fit: BoxFit.fill,
                                  ),
                                  fit: BoxFit.fill,
                                )),
                            Positioned(
                              right: 5,
                              child: IconButton(
                                  onPressed: () {
                                    ///TODO 좋아요 적용 해야함
                                    if (model.like_idx > 0) {
                                      print('');
                                    } else {}
                                    print('${model.like_idx}');
                                  },
                                  icon: model.like_idx == 0
                                      ? const Icon(
                                          Icons.favorite_border_outlined)
                                      : const Icon(Icons.favorite)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(left: 10),
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      model.content_title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(model.content_description)),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Container(
              height: 10,
              width: 10,
              color: AppColors.black,
            ),
            itemCount: viewModel.premiumList?.length == null
                ? 0
                : viewModel.premiumList!.length,
            scrollDirection: Axis.horizontal,
          );
        });
  }

  Widget buildCategoryGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 1개의 행에 항목을 3개씩
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(10),
                )),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.grey),
                child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: categoryData[index].text.make()),
              ),
            )
          ],
        );
      },
    );
  }

  Widget buildCategory() {
    return const SizedBox(
      width: 50,
      height: 50,
      //child: Image.asset('assets/images/noimage.png'),
    );
  }

  Widget buildPromotionBanner() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '프로모션 배너',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        Text(
          '클릭하면 해당 프로모션의 상세페이지로 이동합니다.',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget buildListContainer(String title, String folder) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset('assets/images/noimage.png'),
                ),
                width10,
                title.text.size(18).bold.make(),
              ],
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.add_circle_outline))
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 350,
          child: FutureBuilder(
            future: viewModel.selectWeddingPhoto(),
            builder: (builder, context) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: 250,
                        height: 320,
                        color: AppColors.grey,
                        child: context.buildImage(
                            "weding/${viewModel.weddingList[index].content_img_url}"),
                      ),
                      viewModel.weddingList[index].content_title.text.make()
                    ],
                  );
                },
                separatorBuilder: (context, index) => Container(
                  height: 10,
                  width: 10,
                  color: AppColors.white,
                ),
                itemCount: viewModel.weddingList.length,
                scrollDirection: Axis.horizontal,
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildChipListAndContentList(
      String title,
      List<String> chipList,
      List<String> contentList,
      double contentWidth,
      double contentHeight,
      String folder) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: title.text.size(18).bold.make()),
        const Padding(padding: EdgeInsets.only(top: 10)),
        SizedBox(
          width: double.infinity,
          height: 30,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.grey),
                  child: Text(chipList[index],).pSymmetric(h: 5),
                ),
              );
            },
            separatorBuilder: (context, index) => Container(
              height: 10,
              width: 10,
              color: AppColors.white,
            ),
            itemCount: chipList.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        SizedBox(
          width: double.infinity,
          height: contentHeight,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        width: contentWidth,
                        height: contentHeight - 30,
                        color: AppColors.grey,
                        //child: Image.asset('assets/images/$folder/$index.jpg', fit: BoxFit.fill,),
                      ),
                      Text('item ${contentList[index]}')
                    ],
                  ));
            },
            separatorBuilder: (context, index) => Container(
              width: 10,
              height: 10,
              color: AppColors.white,
            ),
            itemCount: contentList.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }

  Widget buildPhotoReview() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '사진리뷰',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.add_circle_outline))
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 250,
          child: FutureBuilder(
            future: viewModel.selectReview(),
            builder: (builder, context) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: 150,
                        padding: const EdgeInsets.only(bottom: 10),
                        decoration: const BoxDecoration(
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.black,
                                  offset: Offset(1, 1),
                                  blurRadius: 0.1,
                                  spreadRadius: 0.1),
                            ]),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity - 5,
                              height: 120,
                              color: AppColors.grey,
                            ).pSymmetric(v: 8, h: 8),
                            Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: ClipOval(
                                      child: CachedNetworkImage(
                                    imageUrl:
                                        "${GripUrl.imageUrl}${viewModel.reviewList[index].review_img_url}",
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.fill,
                                  )),
                                ),
                                (viewModel.reviewList[index].account_name ?? "")
                                    .text
                                    .size(10)
                                    .make()
                                    .pSymmetric(v: 4, h: 4),
                              ],
                            ).pSymmetric(v: 8, h: 8),
                            Text(
                              viewModel.reviewList[index].review_title,
                              style: const TextStyle(fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ).pSymmetric(v: 4, h: 4)
                          ],
                        ),
                      ).pOnly(left: 10, right: 10, top: 0),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                  width: 10,
                ),
                itemCount: viewModel.reviewList.length,
                scrollDirection: Axis.horizontal,
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildFooter() {
    return Container(
      width: double.infinity,
      height: 150,
      color: AppColors.grey,
      child: const Center(
        child: Text(
          'footer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
