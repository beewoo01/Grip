import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/screen/myinfo/widget/review/viewModel/vm_review.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../vo/vo_wrote_review.dart';

class ReviewDetail extends StatelessWidget {
  ReviewViewModel viewModel = ReviewViewModel();
  WroteReviewVO vo = WroteReviewVO(
      2,
      1,
      '1번 웨딩',
      '1번 웨딩입니다.',
      'weding/wedding1.png',
      '웨딩 작가 리뷰1',
      '웨딩 작가 리뷰1의 내용입니다.',
      '200',
      '테스터2',
      '2023.08.25');

  //ReviewDetail(this.vo, {super.key});
  ReviewDetail({super.key});

  static const String route = '/reviewManagement/reviewDetail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Column(
        children: [
          height10,
          buildContentContainer(context, vo.content_img_url, vo.content_title,
                  vo.content_description)
              .pSymmetric(h: 10),
          height20,
          buildAccountInfoContainer(
                  context, null, vo.account_name, vo.review_createtime)
              .pSymmetric(h: 10),
          height20,
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: vo.review_description.text.color(AppColors.black).make(),
            ),
          ).pSymmetric(h: 10),
          height20,
          Expanded(
            child: buildReviewPhotoList(vo.review_idx),
          ),
          height20,
        ],
      ),
    );
  }

  Widget buildContentContainer(
      BuildContext context, String? url, String title, String description) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: context.buildImage("$url"),
            )),
        Expanded(
            child: Container(
          height: 50,
          decoration: const BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    title.text.color(AppColors.black).size(10).make(),
                    width5,
                    description.text.color(AppColors.black).size(10).make()
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.black,
                  size: 15,
                ),
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget buildAccountInfoContainer(
      BuildContext context, String? url, String name, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: AppColors.darkGrey,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: context.buildImage("$url"),
            ),
            width10,
            name.text.color(AppColors.black).size(15).make()
          ],
        )),
        date.text.color(AppColors.black).size(15).make()
      ],
    );
  }

  Widget buildReviewPhotoList(int reviewIdx) {
    return FutureBuilder(
        future: viewModel.selectReviewImg(reviewIdx),
        builder: (builder, snapShot) {
          return ListView.builder(
            itemCount: snapShot.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: context.buildImage("${snapShot.data?[index]}"),
              ),
            ).pSymmetric(h: 10, v: 20);
          });
        });
  }
}
