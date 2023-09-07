import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/community/community_register.dart';
import 'package:grip/community/community_viewmodel.dart';
import 'package:grip/community/community_write.dart';
import 'package:grip/main.dart';
import 'package:grip/model/inquiry_model.dart';

import '../model/review_model.dart';

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
  Color photoBackgroundColor = Colors.black;
  Color photoTextColor = Colors.white;
  Color questionBackgroundColor = Colors.transparent;
  Color questionTextColor = Colors.black;

  CommunityViewModel viewModel = CommunityViewModel();
  int currentState = 0;

  late final PhotoReviewWidget photoReviewWidget =
      PhotoReviewWidget(viewModel: viewModel);

  late final InquiryListWidget inquiryListWidget = InquiryListWidget(
    viewModel: viewModel,
  );

  // 0 -> 사진리뷰, 1 -> 문의하기

  @override
  void initState() {
    super.initState();
    print('initState');
    getData();
  }

  void getData() async {
    await viewModel.selectReview();
    await viewModel.selectInquiry();
  }

  @override
  Widget build(BuildContext context) {
    print('_CommunitySfw');

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
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: buildDivider(1.5, 1),
                ),
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
                  '커뮤니티',
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

  Widget buildFloatingActionButton(BuildContext context) {
    return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black,
        child: IconButton(
            color: Colors.white,
            onPressed: () {
              navigate(context, CommunityResister.route,
                  isRootNavigator: false, arguments: {});
              /*Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CommunityResister()));*/
            },
            icon: const Icon(Icons.ac_unit)));
  }

  Widget buildBottomCategory() {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: buildBottomCategoryItem(
                  Colors.black, Colors.white, Colors.black, '카테고리'),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
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
      color: Colors.black,
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
                  color: Colors.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/$path',
                    fit: BoxFit.fill,
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 3, bottom: 3),
                  child: Text(
                    name,
                    style: const TextStyle(
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
        currentState = 0;
        photoBackgroundColor = Colors.black;
        questionBackgroundColor = Colors.transparent;
        photoTextColor = Colors.white;
        questionTextColor = Colors.black;
      } else {
        currentState = 1;
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
}

class PhotoReviewWidget extends StatelessWidget {
  final CommunityViewModel viewModel;

  const PhotoReviewWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: viewModel.reviewList?.length,
        itemBuilder: (BuildContext context, int position) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
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
                              child: buildCoverImage(viewModel
                                  .reviewList?[position].review_img_url),
                            ),
                          ),
                        )),
                  ],
                ),
                buildDivider(1, 1)
              ],
            ),
          );
        });
  }

  Widget buildContent(int position) {
    ReviewModel? model = viewModel.reviewList?[position];
    if (model == null) {
      return const Center(
        child: Text(''),
      );
    } else {
      return Column(
        children: [
          buildListText('${model.category_name} * ${model.sub_category_name}',
              10, FontWeight.bold, 1),
          buildListText(model.review_title, 14, FontWeight.bold, 1),
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: buildListText(
                model.review_description, 10, FontWeight.normal, 3),
          )
        ],
      );
    }
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
      color: Colors.black,
    );
  }

  Image buildCoverImage(String? url) => url == null
      ? Image.asset(
          'assets/images/noimage.png',
          fit: BoxFit.fill,
        )
      : Image.network(
          'http://codebrosdev.cafe24.com:8080/media/grip/$url',
          fit: BoxFit.cover,
        );
}

class InquiryListWidget extends StatelessWidget {
  final CommunityViewModel viewModel;

  const InquiryListWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    print('InquiryListWidget build ${viewModel.inquiryList?.length}');
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: viewModel.inquiryList?.length,
        itemBuilder: (BuildContext context, int position) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
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
                              child: buildCoverImage(
                                  //    viewModel.inquiryList![position].
                                  viewModel.inquiryList?[position]
                                      .inquiry_image_url),
                            ),
                          ),
                        )),
                  ],
                ),
                buildDivider(1, 1)
              ],
            ),
          );
        });
  }

  Divider buildDivider(double thickness, double height) {
    return Divider(
      thickness: thickness,
      height: height,
      color: Colors.black,
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
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: buildListText(
              model.inquiry_description, 10, FontWeight.normal, 3),
        )
      ],
    );
  }

  Image buildCoverImage(String? url) => url == null
      ? Image.asset(
          'assets/images/noimage.png',
          fit: BoxFit.fill,
        )
      : Image.network(
          'http://codebrosdev.cafe24.com:8080/media/grip/$url',
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
