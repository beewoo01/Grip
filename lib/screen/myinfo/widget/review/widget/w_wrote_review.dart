import 'package:flutter/material.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../../common/color/AppColors.dart';
import '../../../../../main.dart';

import '../viewModel/vm_review.dart';
import '../vo/vo_wrote_review.dart';
import 'detail/w_review_detail.dart';

class WroteReview extends StatelessWidget {
  ReviewViewModel viewModel;

  WroteReview(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    //TODO CHANGE ACCOUNT IDX
    return FutureBuilder(
        future: viewModel.selectWroteReview(2),
        builder: (builder, snapShot) {
          return ListView.builder(
              itemCount: snapShot.data?.length ?? 0,
              itemBuilder: (BuildContext context, int position) {
                return Column(
                  children: [
                    height20,
                    buildContentBox(snapShot.data?[position], context).pSymmetric(h: 20),
                    height20,
                    buildAccountInfoBox(snapShot.data?[position].account_name,
                        snapShot.data?[position].review_createtime).pSymmetric(h: 20),
                    height20,

                    GestureDetector(
                      onTap: () {
                        /*final vo = ReviewDetail(snapShot.data![position]);
                        navigate(context, ReviewDetail.route,
                            isRootNavigator: false,
                            arguments: {
                              'vo': vo
                            });*/
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                                color: AppColors.grey,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: context.buildImage(snapShot.data?[position].review_img_url ?? ""),
                            ),
                          ),
                          width10,
                          Expanded(
                              child: Container(
                                height: 120,
                                decoration: const BoxDecoration(
                                    color: AppColors.grey,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))
                                ),
                                alignment: Alignment.center,
                                child: snapShot.data?[position].review_description.text.size(10).color(AppColors.black).make(),
                              )
                          )
                        ],
                      ).pSymmetric(h: 20),
                    ),


                    height20,
                    const Line(color: AppColors.grey,)
                  ],
                );
              });
        });
  }

  Widget buildContentBox(WroteReviewVO? model, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          width20,
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: context.buildImage(model?.content_img_url ?? "",
                  errorWidget: (context, url, error){return Container();}
              ),
            ),
          ),
          width20,
          "${model?.content_title}"
              .text
              .color(AppColors.black)
              .size(10)
              .bold
              .make(),
          width10,
          "${model?.content_description}"
              .text
              .color(AppColors.black)
              .size(10)
              .bold
              .make()
        ],
      ).pSymmetric(v: 10),
    );
  }

  Widget buildAccountInfoBox(String? name, String? date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.circular(25)),
        ),
        width5,
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: double.infinity,
                child: "$name".text.color(AppColors.black).size(10).make()),
            SizedBox(
                width: double.infinity,
                child: "$date".text.color(AppColors.black).size(10).make()),
          ],
        ))
      ],
    );
  }
}
