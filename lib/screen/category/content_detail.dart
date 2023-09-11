import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/main.dart';
import 'package:grip/model/content_detail_model.dart';
import 'package:grip/util/util.dart';

import '../community/community_viewmodel.dart';
import 'reservation.dart';

class ContentDetail extends StatefulWidget {
  final String? path;
  final int? contentIdx;

  const ContentDetail(
      {super.key, required this.path, required this.contentIdx});

  static const String route = '/promotion/detail';

  @override
  State<StatefulWidget> createState() =>
      ContentDetailState(path: path, contentIdx: contentIdx);
}

class ContentDetailState extends State<ContentDetail> {
  final String? path;
  final int? contentIdx;

  ContentDetailState({required this.path, required this.contentIdx});

  final PageController _pageController = PageController(initialPage: 0);
  final PageController _pageController2 =
      PageController(viewportFraction: 0.5, keepPage: true);
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
        future: viewModel.selectContentDetail(contentIdx!),
        //future: viewModel.selectContentDetail(contentIdx!),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return buildScaffold();
          } else if (snapShot.hasError) {
            print('${snapShot.hasError}');
            return buildNoDataAppScaffold('데이터 조회중 에러가 발생했습니다.');
          } else {
            return buildNoDataAppScaffold('조회된 데이터가 없습니다.');
          }
        });
  }

  Scaffold buildNoDataAppScaffold(String massage) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: buildAppBar(),
      body: Center(
        child: Text(
          massage,
          style: const TextStyle(color: AppColors.black),
        ),
      ),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10),
                  child: Text(
                    '카테고리 > $path',
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
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
                    itemCount: viewModel.contentImageList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: GestureDetector(
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
                                child: Image.network(
                                    'https://picsum.photos/${viewModel.contentImageList[index].content_img_url}')),
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
                          child: Text(
                            '${viewModel.contentDetailModel?.content_title}',
                            style: const TextStyle(
                                color: AppColors.black,
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
                          child: Row(
                            children: [
                              const Icon(Icons.location_pin, color: AppColors.darkGrey,),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  '${viewModel.contentDetailModel?.content_address}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: AppColors.black, fontSize: 15),
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
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(20)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                '${viewModel.contentDetailModel?.content_description}'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.black, width: 1.0),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 2), child: Icon(Icons.favorite),),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 2), child: Text('찜하기'),)
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
                              navigate(context, Reservation.route,
                                  isRootNavigator: false,
                                  arguments: {'content_idx': contentIdx});
                            },
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                side: const BorderSide(
                                    color: AppColors.black, width: 0.8)),
                            child: const Text(
                              '예약하기',
                              style:
                                  TextStyle(color: AppColors.black, fontSize: 20),
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
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            '${viewModel.contentDetailModel?.content_description}',
                            //'브랜드 소개에 관한\n내용을 작성해 주세요',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 15),
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
                                    color: AppColors.black,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    )),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    '촬영 상품 설명',
                                    style: TextStyle(
                                        color: AppColors.white,
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
                                    color: AppColors.grey,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: Text(
                                    '${viewModel.contentDetailModel?.content_address}',
                                    //'00시 00구 00동 0000',
                                    style: const TextStyle(
                                        fontSize: 13, color: AppColors.black),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: 250,
                                  height: 250,
                                  color: AppColors.grey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 20),
                                child: buildDivider(),
                              )
                            ],
                          ),
                        ),
                      ),
                      /*Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, bottom: 10, right: 10),
                          child: buildInquiry()),*/
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

  Widget buildPageView() {
    print('buildPageView + ${viewModel.contentImageList.length}');
    if (viewModel.contentImageList.isNotEmpty) {
      return SizedBox(
        width: double.infinity,
        height: 300,
        child: PageView.builder(
          itemCount: viewModel.contentImageList.length,
          itemBuilder: (_, index) {
            return Image.network(
                'https://picsum.photos/${viewModel.contentImageList[index].content_img_url}');
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
                fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 20),
          ),
        ),
        SizedBox(
            height: 350,
            child: Container(
              color: Colors.pink,
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
          child: Container(
            color: Colors.green,
          ),
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
          Icons.chevron_left,
          color: AppColors.black,
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
      ],
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
