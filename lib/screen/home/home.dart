import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_circulator_progress.dart';
import 'package:grip/common/widget/w_container_image.dart';
import 'package:grip/common/widget/w_default_appbar.dart';
import 'package:grip/common/widget/w_height_and_width.dart';

import 'package:grip/main.dart';
import 'package:grip/common/widget/drawer/drawer.dart';
import 'package:grip/screen/category/content_detail.dart';
import 'package:grip/screen/home/vm_home.dart';
import 'package:grip/screen/home/vo/vo_wedding.dart';
import 'package:grip/screen/home/widget/w_content_title.dart';
import 'package:grip/screen/home/widget/w_find_model.dart';
import 'package:grip/screen/myinfo/join.dart';
import 'package:grip/screen/myinfo/login.dart';
import 'package:grip/screen/myinfo/my_page.dart';
import 'package:grip/screen/myinfo/widget/review/viewModel/vm_review.dart';
import 'package:grip/screen/myinfo/widget/review/vo/vo_wrote_review.dart';
import 'package:grip/screen/myinfo/widget/review/widget/detail/w_review_detail.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/url/grip_url.dart';
import '../../common/widget/w_separator_container.dart';
import '../category/category_watch.dart';
import 'widget/w_build_chip_horizontal_list.dart';
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

              case DrawerWidget.route:
                builder = (BuildContext _) => const DrawerWidget();
                break;

              case Login.route:
                builder = (BuildContext _) {
                  final root = (settings.arguments as Map)['isCategoryRoot'];
                  return Login(isCategoryRoot: root);
                };
                break;

              case Join.route:
                builder = (BuildContext _) => const Join();
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


              case ReviewDetail.route:
                final viewModel = (settings.arguments as Map)['viewModel'];
                final vo = (settings.arguments as Map)['vo'];
                builder = (BuildContext _) => ReviewDetail(viewModel, vo);
                break;

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

  int currentPage = 0;
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage < viewModel.eventLength - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: DefaultAppBar().createAppbar(callback: () {
        navigate(context, DrawerWidget.route, isRootNavigator: false);
      }),
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
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              "assets/images/premium_d.png",
                            ).pSymmetric(h: 10),
                          ),
                          '프리미엄'
                              .text
                              .color(AppColors.white)
                              .bold
                              .size(18)
                              .make()
                              .pSymmetric(h: 10),
                        ],
                      ),
                    ),
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
              height: 120,
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
                    child: ChipHorizontalList(
                      viewModel,
                      1,
                      callback: (categoryIdx, subCategoryIdx, categoryName) {
                        navigate(context, CategoryWatch.route,
                            isRootNavigator: false,
                            arguments: {
                              'idx': categoryIdx,
                              'subIdx': subCategoryIdx,
                              'title': categoryName,
                              'list': viewModel.subCategoryMap?[categoryIdx]
                              //여기
                            });
                      },
                    )),
                height20,
                SizedBox(
                    width: double.infinity,
                    height: 320,
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
                BuildChipHorizontalList(viewModel: viewModel, categoryIdx: 2),
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
                BuildChipHorizontalList(viewModel: viewModel, categoryIdx: 3),
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
                BuildChipHorizontalList(viewModel: viewModel, categoryIdx: 4),
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

  /*AppBar buildAppBar() {
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
      title: SizedBox(
        height: 30,
        child: Image.asset("assets/images/app_logo.png"),
      ),
      actions: [
        IconButton(
            onPressed: () {
              navigate(context, DrawerWidget.route,
                  isRootNavigator: false);
            },
            icon: Image.asset("assets/images/category_ic.png"))
      ],

    );
  }*/

  Widget buildPageView() {
    return FutureBuilder(
        future: viewModel.selectEvent(),
        builder: (builder, snapShot) {
          return Container(
              width: double.infinity,
              height: 400,
              color: AppColors.grey,
              //color: AppColors.grey,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: snapShot.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: double.infinity,
                              height: 400,
                              color: AppColors.white,
                              child: context.buildImage(
                                  snapShot.data?[index].event_img_url ?? "",
                                  fit: BoxFit.contain,
                                  isShowPlaceHolder: false));
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
                    Container(
                      width: double.infinity,
                      height: 200,
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
                                    const CircularProgressWidget(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/noimage.png',
                                  fit: BoxFit.fill,
                                ),
                                fit: BoxFit.cover,
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
                                    ? const Icon(Icons.favorite_border_outlined)
                                    : const Icon(Icons.favorite)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        height: 50,
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
                        ))
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
    return FutureBuilder(
        future: viewModel.selectCategory(),
        builder: (context, snapShot) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 1개의 행에 항목을 3개씩
                childAspectRatio: 1,
                crossAxisSpacing: 3),
            itemCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    print("GestureDetector");
                    int idx = index + 1;
                    navigate(context, CategoryWatch.route,
                        isRootNavigator: false,
                        arguments: {
                          'idx': index + 1,
                          'subIdx': viewModel.subCategoryMap?[idx]?.first.first,
                          'title': viewModel.categoryMap?[idx],
                          'list': viewModel.subCategoryMap?[idx]
                          //여기
                        });
                  },
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(12),
                              ))),
                      height10,
                      Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.grey),
                              child: viewModel.categoryMap?[index + 1]?.text
                                  .size(15)
                                  .make()
                                  .pSymmetric(h: 5))
                          .pSymmetric(h: 10)
                    ],
                  ));
            },
          );
        });
  }

  Widget buildCategory() {
    return const SizedBox(
      width: 50,
      height: 50,
      //child: Image.asset('assets/images/noimage.png'),
    );
  }

  Widget buildPromotionBanner() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        "프로모션 배너".text.size(25).bold.make(),
        "클릭하면 해당 프로모션의 상세페이지로 이동합니다.".text.size(15).make(),
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
        return GestureDetector(
          onTap: () {
            navigate(context, ContentDetail.route,
                isRootNavigator: false,
                arguments: {
                  'root': list?[index].content_title ?? "",
                  'content_idx': list?[index].content_idx ?? 0
                });
          },
          child: Column(
            children: [
              ContainerImageWidget(250, 320, "${list?[index].content_img_url}"),
              "${list?[index].content_title}".text.make()
            ],
          ),
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
            builder: (builder, snapShot) {
              return ChipHorizontalList(
                viewModel,
                categoryIdx,
                callback: (categoryIdx, subCategoryIdx, categoryName) {
                  navigate(context, CategoryWatch.route,
                      isRootNavigator: false,
                      arguments: {
                        'idx': categoryIdx,
                        'subIdx': subCategoryIdx,
                        'title': categoryName,
                        'list': viewModel.subCategoryMap?[categoryIdx]
                        //여기
                      });
                },
              );
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
                  return GestureDetector(
                    onTap: () async {
                      int? reviewIdx = snapShot.data?[index].review_idx;
                      if (reviewIdx == null) {
                        return;
                      }
                      WroteReviewVO? wroteReviewVO =
                      await viewModel.selectOneWroteReview(reviewIdx);

                      if (wroteReviewVO == null) {
                        return;
                      }

                      if(context.mounted) {
                        navigate(context, ReviewDetail.route,
                            isRootNavigator: false,
                            arguments: {
                              'vo': wroteReviewVO,
                              'viewModel': ReviewViewModel()
                            });
                      }
                    },
                    child: Container(
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
                    ).pOnly(left: 10, right: 10, top: 0, bottom: 10),
                  );
                },
                separatorBuilder: (context, index) => separator10,
                itemCount: snapShot.data?.length ?? 0,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 25,
            child: Image.asset("assets/images/app_logo_footer.png"),
          ).pSymmetric(h: 20),
          height20,
          "footer".text.bold.color(AppColors.grey).size(25).make(),
        ],
      ),
    );
  }
}
