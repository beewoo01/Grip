import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/drawer/drawer.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/main.dart';
import 'package:grip/model/content_detail_model.dart';
import 'package:grip/util/util.dart';
import 'package:velocity_x/velocity_x.dart';

import '../community/community_viewmodel.dart';
import 'reservation.dart';

class ContentDetail extends StatefulWidget {
  final String? path;
  final int? contentIdx;

  const ContentDetail(
      {super.key, required this.path, required this.contentIdx});

  static const String route = '/promotion/detail';

  @override
  State<StatefulWidget> createState() => ContentDetailState();
}

class ContentDetailState extends State<ContentDetail> {
  final PageController _pageController = PageController(initialPage: 0);
  int pageViewLength = 2;
  List pages = [];
  int selectedPagePosition = 0;

  CommunityViewModel viewModel = CommunityViewModel();

  @override
  void initState() {
    super.initState();
    print('ContentDetailState initState');
    //viewModel.selectContentImage(2);
    //pages = generatePages();
  }

  @override
  Widget build(BuildContext context) {
    print('ContentDetailState build');

    return FutureBuilder(
        future: viewModel.selectContentDetail(widget.contentIdx!),
        //future: viewModel.selectContentDetail(contentIdx!),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return buildScaffold(context);
          } else if (snapShot.hasError) {
            print('${snapShot.hasError}');
            return const SizedBox(
              height: 200.0,
              width: 200.0,
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return const SizedBox(
              height: 200.0,
              width: 200.0,
              child: Center(child: CircularProgressIndicator()),
            );
            //buildNoDataAppScaffold('조회된 데이터가 없습니다.');
          }
        });
  }

  Widget buildNoDataAppScaffold(String massage) {
    return const SizedBox(
        width: 50, height: 50, child: CircularProgressIndicator());
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                  child: "${widget.path}"
                      .text
                      .size(13)
                      .bold
                      .align(TextAlign.left)
                      .make()
                      .pOnly(left: 10, top: 12, bottom: 12)),

              buildDivider(),
              height20,
              buildPageView(context),
              height20,
              SizedBox(
                height: 80,
                child: ListView.builder(
                  physics: const PageScrollPhysics(), // PageScrollPhysics 사용
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.contentImageList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _pageController.jumpToPage(index);
                      },
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              child: context.buildImage(
                                  viewModel
                                      .contentImageList[index].content_img_url,
                                  fit: BoxFit.cover))
                          //Image.network('https://picsum.photos/${viewModel.contentImageList[index].content_img_url}')),
                          ),
                    ).pSymmetric(h: 10);
                  },
                ),
              ),
              height30,
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    '${viewModel.contentDetailModel?.content_title}'
                        .text
                        .color(AppColors.black)
                        .bold
                        .size(20)
                        .align(TextAlign.left)
                        .make()
                        .pOnly(left: 10),
                    height5,
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: AppColors.darkGrey,
                          ),
                          '${viewModel.contentDetailModel?.content_address}'
                              .text
                              .color(AppColors.black)
                              .align(TextAlign.left)
                              .size(15)
                              .make()
                              .pOnly(left: 5)
                        ],
                      ),
                    ).pOnly(left: 10),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Align(
                        alignment: Alignment.center,
                        child:
                            '${viewModel.contentDetailModel?.content_description}'
                                .text
                                .make(),
                      ),
                    ).p(10),
                    height20,
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.black, width: 1.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.favorite).pSymmetric(h: 2),
                          "찜하기".text.black.make().pSymmetric(h: 2),
                        ],
                      ),
                    ),
                    buildDivider().pSymmetric(h: 10, v: 10),
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () {
                          navigate(context, Reservation.route,
                              isRootNavigator: false,
                              arguments: {'content_idx': widget.contentIdx});
                        },
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            side: const BorderSide(
                                color: AppColors.black, width: 0.8)),
                        child: '예약하기'.text.black.size(20).make(),
                      ),
                    ).pSymmetric(h: 10, v: 10),
                    buildDivider().pSymmetric(h: 10, v: 10),
                    height20,
                    Center(child: '브랜드 소개글'.text.bold.size(20).make()),
                    height20,
                    Center(
                      child: Container(
                        width: 1,
                        height: 100,
                        color: AppColors.black,
                      ),
                    ),
                    '${viewModel.contentDetailModel?.content_description}'
                        .text
                        .center
                        .size(15)
                        .make()
                        .pOnly(top: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  )),
                              child: '촬영 상품 설명'
                                  .text
                                  .color(Colors.white)
                                  .size(15)
                                  .bold
                                  .make()
                                  .pOnly(left: 20, top: 10)),
                          buildProductDescription(),
                          height30,
                          buildDivider().pSymmetric(h: 10),
                          height20,
                          "오시는 길".text.bold.color(Colors.black).size(18).make(),
                          Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.grey,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child:
                                      '${viewModel.contentDetailModel?.content_address}'
                                          .text
                                          .size(13)
                                          .color(Colors.black)
                                          .make())
                              .pOnly(top: 20),
                          height20,
                          Container(
                            width: 250,
                            height: 250,
                            color: AppColors.grey,
                          ).pOnly(top: 20),
                          buildDivider().pSymmetric(h: 10)
                        ],
                      ),
                    ).pOnly(top: 20, left: 10, right: 10),
                    const Padding(padding: EdgeInsets.only(bottom: 100))
                  ],
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
          color: AppColors.white,
          border: Border.all(width: 1, color: AppColors.black),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          )),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    '${viewModel.contentDetailModel?.struct_description}',
                    //'상품에 대한 내용을 작성해 주세요',
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generatePages() {
    print('generatePages');
    return List.generate(
        viewModel.contentImageList.length,
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
                    "Pag1bree ${viewModel.contentImageList[index].content_img_url}",
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
      color: AppColors.black,
    );
  }

  Widget buildPageView(BuildContext context) {
    print('buildPageView + ${viewModel.contentImageList.length}');
    if (viewModel.contentImageList.isNotEmpty) {
      return SizedBox(
        width: double.infinity,
        height: 300,
        child: PageView.builder(
          itemCount: viewModel.contentImageList.length,
          itemBuilder: (_, index) {
            return context.buildImage(
                viewModel.contentImageList[index].content_img_url,
                fit: BoxFit.cover);
          },
          controller: _pageController,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildInquiry() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '문의하기',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontSize: 20),
          ),
        ),
        SizedBox(
            height: 350,
            child: Container(
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                return buildInquiryItem();
              }),
            ))
      ],
    );
  }

  Widget buildInquiryItem() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              color: AppColors.black,
            ) //Text('닉네임'),
            ),
        Expanded(
          child: Container(),
          //child: Text('공간 벽쪽에 있는 테이블 크기 문의 드립니다.'),
          flex: 8,
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.deepPurple,
          ),
          //child: Text('23.01.01'),
        )
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              navigate(context, DrawerWidget.route,
                  isRootNavigator: false);
            },
            icon: Image.asset("assets/images/category_ic.png"))
      ],

      automaticallyImplyLeading: false,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Divider(
          thickness: 1,
          height: 1,
          color: AppColors.black,
        ),
      ),
    );
  }
}
