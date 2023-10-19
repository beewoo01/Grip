import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/drawer/drawer.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/main.dart';
import 'package:grip/model/inquiry_model.dart';
import 'package:grip/model/review_model.dart';
import 'package:grip/screen/community/community_register.dart';
import 'package:grip/screen/community/community_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:grip/screen/myinfo/widget/review/viewModel/vm_review.dart';
import 'package:grip/screen/myinfo/widget/review/vo/vo_wrote_review.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/url/grip_url.dart';
import '../../util/Singleton.dart';
import '../myinfo/widget/review/widget/detail/w_review_detail.dart';

class CommunityMenu extends StatelessWidget {
  const CommunityMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(),
        child: Navigator(
          key: communityKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const Community();
                break;

              case CommunityResister.route:
                print('case CommunityResister.route');
                builder = (BuildContext _) => const CommunityResister();
                break;

              case ReviewDetail.route:
                final viewModel = (settings.arguments as Map)['viewModel'];
                final vo = (settings.arguments as Map)['vo'];
                builder = (BuildContext _) => ReviewDetail(viewModel, vo);
                break;


              case DrawerWidget.route :
                builder = (BuildContext _) => const DrawerWidget();
                break;

              default:
                builder = (BuildContext _) => const Community();
            }

            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ));
  }
}

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State createState() => CommunitySfw();
}

class CommunitySfw extends State<Community> {
  bool isPhotoReview = true;
  Color photoBackgroundColor = AppColors.black;
  Color photoTextColor = AppColors.white;
  Color questionBackgroundColor = Colors.transparent;
  Color questionTextColor = AppColors.black;

  CommunityViewModel viewModel = CommunityViewModel();
  int currentState = 0;

  late final PhotoReviewWidget photoReviewWidget =
      PhotoReviewWidget(viewModel: viewModel);

  late final InquiryListWidget inquiryListWidget = InquiryListWidget(
    viewModel: viewModel,
  );

  @override
  Widget build(BuildContext context) {
    print('_CommunitySfw build');
    return buildAppScaffold();
  }

  Scaffold buildEmptyList() {
    return Scaffold(
      appBar: buildAppBar(),
      body: const Center(
        child: Text(''),
      ),
    );
  }

  Scaffold buildAppScaffold() {
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                //buildAppBar(),
                buildDivider(2, 1),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: buildPhotoAndQuestion(),
                ),
                Container(
                  child: buildMiddleCategory(),
                ),

                const Line().pSymmetric(h: 10, v: 10),

                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: buildBottomCategory(),
                ),

                Expanded(
                    child: currentState == 0
                        ? photoReviewWidget
                        : inquiryListWidget),

                const Padding(padding: EdgeInsets.only(bottom: 60))
                //buildCommunityList()
              ],
            ),
          ),
          Positioned(
              bottom: 80, right: 15, child: buildFloatingActionButton(context)),
        ],
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
          children: [
            '커뮤니티'.text.size(15).bold.black.make(),
            Expanded(child: Container()),
            SizedBox(
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    navigate(context, DrawerWidget.route,
                        isRootNavigator: false);
                  },
                  child: Image.asset(
                    "assets/images/category_ic.png",
                    fit: BoxFit.cover,
                  ),
                ))
            /*'커뮤니티'.text.size(15).bold.black.make(),
            Expanded(child: Container()),
            *//*(Singleton().getAccountName() ?? "")
                .text
                .size(13)
                .bold
                .color(AppColors.black)
                .make(),*//*

            SizedBox(
              width: 50,
              height: 50,
              child: IconButton(
                icon: Image.asset(
                  "assets/images/category_ic.png",
                  fit: BoxFit.cover,
                ),
                onPressed: () {
                  navigate(context, DrawerWidget.route,
                      isRootNavigator: false);
                },
              ),
            )*/

          ],
        ));
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.black,
        child: IconButton(
            color: AppColors.white,
            onPressed: () {
              navigate(context, CommunityResister.route,
                  isRootNavigator: false, arguments: {});
              /*Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CommunityResister()));*/
            },
            icon: const Icon(Icons.ac_unit)));
  }

  Widget buildBottomCategory() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: buildBottomCategoryItem(
                AppColors.black, AppColors.white, AppColors.black, '카테고리'),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: buildBottomCategoryItem(
                AppColors.black, AppColors.black, AppColors.white, '세부 카테고리'),
          ),
        )
      ],
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
        padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
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
              padding: const EdgeInsets.only(left: 3),
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
      color: AppColors.black,
    );
  }

  Widget buildPhotoAndQuestion() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
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
        Expanded(child: buildMiddleCategoryBox(0, '스냅촬영', 'snap/0.jpg')),
        Expanded(child: buildMiddleCategoryBox(1, '영상촬영', 'movie/0.jpg')),
        Expanded(child: buildMiddleCategoryBox(2, '모델', 'model/0.jpg')),
        Expanded(child: buildMiddleCategoryBox(3, '공간대여', 'studio/0.jpg')),
      ],
    );
  }

  Widget buildMiddleCategoryBox(int position, String name, String path) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.grey,
                ),
                /*child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/$path',
                    fit: BoxFit.fill,
                  ),
                ),*/
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppColors.grey,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 3, bottom: 3),
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.black,
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
        currentState = 0;
        photoBackgroundColor = AppColors.black;
        questionBackgroundColor = Colors.transparent;
        photoTextColor = AppColors.white;
        questionTextColor = AppColors.black;
      } else {
        currentState = 1;
        photoBackgroundColor = Colors.transparent;
        questionBackgroundColor = AppColors.black;
        photoTextColor = AppColors.black;
        questionTextColor = AppColors.white;
      }
    });
  }

  Widget buildCategory() {
    return Container();
  }
}

class PhotoReviewWidget extends StatelessWidget {
  final CommunityViewModel viewModel;

  const PhotoReviewWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: viewModel.selectReview(),
        builder: (context, snapShot) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapShot.data?.length,
              itemBuilder: (BuildContext context, int position) {
                return GestureDetector(
                  onTap: () async {
                    final reviewIdx = snapShot.data?[position].review_idx;
                    if (reviewIdx == null) {
                      return;
                    }

                    WroteReviewVO? wroteReviewVO =
                        await viewModel.selectOneWroteReview(reviewIdx);

                    if (wroteReviewVO == null) {
                      return;
                    }

                    if (context.mounted) {
                      navigate(context, ReviewDetail.route,
                          isRootNavigator: false,
                          arguments: {
                            'vo': wroteReviewVO,
                            'viewModel': ReviewViewModel()
                          });
                    }
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.only(left: 5),
                              child: buildContent(snapShot.data?[position]),
                            ),
                          ),
                          SizedBox(
                              width: 100,
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey,
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: context.buildImage(
                                          "${snapShot.data?[position].review_img_url}")

                                      /*buildCoverImage(viewModel
                                        .reviewList?[position].review_img_url),*/
                                      ),
                                ),
                              )),
                        ],
                      ),
                      buildDivider(1, 1)
                    ],
                  ).pOnly(left: 10, right: 10, top: 10),
                );
              });
        });
  }

  Widget buildContent(ReviewModel? model) {
    //ReviewModel model = viewModel.reviewList[position];

    return Column(
      children: [
        buildListText("${model?.category_name} * ${model?.sub_category_name}",
            10, FontWeight.bold, 1),
        buildListText(model?.review_title ?? "", 14, FontWeight.bold, 1),
        buildListText(model?.review_description ?? "", 10, FontWeight.normal, 3)
            .pOnly(top: 1)
      ],
    );
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

  Divider buildDivider(double thickness, double height) {
    return Divider(
      thickness: thickness,
      height: height,
      color: AppColors.black,
    );
  }

  Image buildCoverImage(String? url) => url == null
      ? Image.asset(
          'assets/images/noimage.png',
          fit: BoxFit.fill,
        )
      : Image.network(
          '${GripUrl.imageUrl}$url',
          fit: BoxFit.cover,
        );
}

class InquiryListWidget extends StatelessWidget {
  final CommunityViewModel viewModel;

  const InquiryListWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: viewModel.selectInquiry(),
        builder: (builder, context) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: viewModel.inquiryList?.length,
              itemBuilder: (BuildContext context, int position) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.only(left: 5),
                            child: buildContent(position),
                          ),
                        ),
                        SizedBox(
                            width: 100,
                            height: 100,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: buildCoverImage(
                                    //    viewModel.inquiryList![position].
                                    viewModel.inquiryList?[position]
                                        .inquiry_image_url),
                              ),
                            ).pSymmetric(v: 8, h: 8)),
                      ],
                    ),
                    buildDivider(1, 1)
                  ],
                ).pOnly(top: 10, left: 10, right: 10);
              });
        });
  }

  Divider buildDivider(double thickness, double height) {
    return Divider(
      thickness: thickness,
      height: height,
      color: AppColors.black,
    );
  }

  Widget buildContent(int position) {
    InquiryModel? model = viewModel.inquiryList?[position];
    if (model == null) {
      return const Center(
        child: Text('항목이 비어 있습니다.'),
      );
    }

    return Column(
      children: [
        buildListText(model.sources, 10, FontWeight.bold, 1),
        buildListText(model.inquiry_title, 14, FontWeight.bold, 1),
        buildListText(model.inquiry_description, 10, FontWeight.normal, 3)
            .pOnly(top: 1)
      ],
    );
  }

  Image buildCoverImage(String? url) => url == null
      ? Image.asset(
          'assets/images/noimage.png',
          fit: BoxFit.fill,
        )
      : Image.network(
          '${GripUrl.imageUrl}$url',
          fit: BoxFit.cover,
        );

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
}
