import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_container_image.dart';
import 'package:grip/common/widget/w_height_and_width.dart';

import 'package:grip/main.dart';
import 'package:grip/screen/home/vm_home.dart';
import 'package:grip/screen/home/vo/vo_wedding.dart';
import 'package:grip/screen/home/widget/w_content_title.dart';
import 'package:grip/screen/home/widget/w_find_model.dart';
import 'package:grip/screen/myinfo/alarm/fragment/f_alarm.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/url/grip_url.dart';
import '../../common/widget/w_separator_container.dart';
import '../../common/widget/w_test.dart';
import 'widget/w_chip_horizontal_list.dart';

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
              /*case AlarmFragment.route :
                builder = (BuildContext _) => const AlarmFragment();
                break;
                */
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
    /*if (Singleton().getAccountIdx() == null) {
      Singleton().setAccountIdx(2);
    }*/

    /*viewModel.selectPremiumModel(Singleton().getAccountIdx()!);
    viewModel.selectEvent();*/
  }

  @override
  Widget build(BuildContext context) {
    print("HOME BUILD");
    return Scaffold(
      backgroundColor: AppColors.white,
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
            Column(
              children: [
                const ContentTitleWidget("웨딩 사진 촬영"),
                buildWeddingListContainer(),
              ],
            ).pSymmetric(h: 10),
            height20,
            Column(
              children: [
                const ContentTitleWidget("최근 핫한 공간!!"),
                buildHotPlaceListContainer()
              ],
            ).pSymmetric(h: 10),
            height20,
            Column(
              children: [
                const ContentTitleWidget("이달의 인기 스냅촬영"),
                height5,
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ChipHorizontalList(viewModel, 1),
                ),
                height20,
                SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: FutureBuilder(
                      future: viewModel.selectPicturesByCategory(1),
                      builder: (builder, snapShot) {
                        return FindModelWidget(snapShot.data ?? [], 250);
                      },
                    ))
              ],
            ).pSymmetric(h: 10),
            height20,
            Column(
              children: [
                const ContentTitleWidget("이달의 인기 영상촬영"),
                height5,
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ChipHorizontalList(viewModel, 1),
                ),
                height20,
                SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: FutureBuilder(
                      future: viewModel.selectPicturesByCategory(2),
                      builder: (builder, snapShot) {
                        return FindModelWidget(snapShot.data ?? [], 250);
                      },
                    ))
              ],
            ).pSymmetric(h: 10),
            height30,
            Column(
              children: [
                const ContentTitleWidget("우리가 찾는 모델"),
                height5,
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ChipHorizontalList(viewModel, 1),
                ),
                height20,
                SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: FutureBuilder(
                      future: viewModel.selectFindModel(),
                      builder: (builder, snapShot) {
                        return FindModelWidget(snapShot.data ?? [], 200);
                      },
                    ))
              ],
            ).pSymmetric(h: 10),
            height30,
            Column(
              children: [
                const ContentTitleWidget("이달의 인기 공간"),
                height5,
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ChipHorizontalList(viewModel, 1),
                ),
                height20,
                SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: FutureBuilder(
                      future: viewModel.selectPicturesByCategory(4),
                      builder: (builder, snapShot) {
                        return FindModelWidget(snapShot.data ?? [], 250);
                      },
                    ))
              ],
            ).pSymmetric(h: 10),
            height10,
            buildPhotoReview().pSymmetric(h: 10),
            height10,
            buildFooter().pOnly(bottom: 60, left: 10, right: 10),

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
                    Expanded(
                      flex: 1,
                      child: (Singleton().getAccountName() ?? "").text.size(13).bold.color(AppColors.black).make()
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
        builder: (builder, snapShot) {
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
                        itemCount: snapShot.data?.length ?? 0,
                        //viewModel.eventList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: double.infinity,
                              height: 400,
                              color: AppColors.black,
                              child: context.buildImage(
                                snapShot.data?[index].event_img_url ?? "",
                              ));
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
        future: viewModel.selectPremiumModel(Singleton().getAccountIdx()),
        builder: (builder, snapShot) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final model = snapShot.data?[index];
              //viewModel.premiumList?[index];
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
            separatorBuilder: (context, index) => const SeparatorContainer(
              10,
              10,
              color: AppColors.black,
            ),
            itemCount: snapShot.data?.length ?? 0,
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

  Widget buildHotPlaceListContainer() {
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: FutureBuilder(
        future: viewModel.selectHotSpace(),
        builder: (builder, snapShot) {
          return buildContentList(snapShot.data);
        },
      ),
    );
  }

  Widget buildWeddingListContainer() {
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: FutureBuilder(
        future: viewModel.selectWeddingPhoto(),
        builder: (builder, snapShot) {
          return buildContentList(snapShot.data);
        },
      ),
    );
  }

  ListView buildContentList(List<WeddingVO>? list) {
    return ListView.separated(
      itemBuilder: (context, index) {
        print("buildContentList");
        print("${list?[index].content_img_url}");
        return Column(
          children: [
            ContainerImageWidget(250, 320, "${list?[index].content_img_url}"),
            "${list?[index].content_title}".text.make()
          ],
        );
      },
      separatorBuilder: (context, index) => separator10,
      itemCount: list?.length ?? 0,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget buildChipListAndContentList(String title, double contentWidth,
      double contentHeight, String folder, int categoryIdx) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: title.text.size(18).bold.make()),
        height10,
        SizedBox(
          width: double.infinity,
          height: 30,
          child: FutureBuilder(
            future: viewModel.selectFindModel(),
            builder: (builder, context) {
              return ChipHorizontalList(viewModel, categoryIdx);
            },
          ),
        ),
        height20,
        SizedBox(
            width: double.infinity,
            height: contentHeight,
            child: FutureBuilder(
              future: viewModel.selectFindModel(),
              builder: (builder, snapShot) {
                return FindModelWidget(snapShot.data ?? [], 250);
              },
            )),
      ],
    );
  }

  Widget buildPhotoReview() {
    return Column(
      children: [
        const ContentTitleWidget("사진 리뷰"),
        Container(
          width: double.infinity,
          height: 200,
          color: Colors.white,
          child: FutureBuilder(
            future: viewModel.selectReview(),
            builder: (builder, snapShot) {
              return ListView.separated(
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    height: 180,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration:
                        const BoxDecoration(color: AppColors.white, boxShadow: [
                      BoxShadow(
                          color: AppColors.black,
                          offset: Offset(1, 1),
                          blurRadius: 0.1,
                          spreadRadius: 0.1),
                    ]),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                            flex: 8,
                            child: ContainerImageWidget(
                                    double.infinity,
                                    double.infinity,
                                    "${snapShot.data?[index].review_img_url}")
                                .pSymmetric(h: 5, v: 5)),
                        Expanded(
                          flex: 3,
                          child: Container(),
                        ),
                      ],
                    ),
                  ).pOnly(left: 10, right: 10, top: 0, bottom: 10);
                },
                separatorBuilder: (context, index) => separator10,
                itemCount:  snapShot.data?.length ?? 0,
                //viewModel.reviewList.length,
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
