import 'package:flutter/material.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_loading.dart';
import 'package:grip/main.dart';
import 'package:grip/screen/category/content_detail.dart';
import 'package:grip/screen/community/community_register.dart';
import 'package:grip/screen/myinfo/widget/review/viewModel/vm_review.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../common/color/AppColors.dart';

class WillWriteReview extends StatelessWidget {
  ReviewViewModel viewModel;

  WillWriteReview(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        //future: viewModel.selectPossibleWriteReview(Singleton().getAccountIdx()),
        future:
            viewModel.selectPossibleWriteReview(Singleton().getAccountIdx()),
        builder: (builder, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          return ListView.builder(
              itemCount: snapShot.data?.length ?? 0,
              itemBuilder: (BuildContext context, int position) {
                return Container(
                    decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        height30,
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    width20,
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: AppColors.darkGrey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: context.buildImage(
                                            "${snapShot.data?[position].content_img_url}",
                                            errorWidget: (context, url, error) {
                                          return Container();
                                        }),
                                      ),
                                    ),
                                    width10,
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child:
                                              "${snapShot.data?[position].content_title}"
                                                  .text
                                                  .maxLines(1)
                                                  .ellipsis
                                                  .color(AppColors.black)
                                                  .bold
                                                  .bold
                                                  .make(),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child:
                                              "${snapShot.data?[position].content_description}"
                                                  .text
                                                  .maxLines(1)
                                                  .ellipsis
                                                  .color(AppColors.black)
                                                  .bold
                                                  .make(),
                                        ),
                                        height5,
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: "${snapShot.data?[position].reservation_date ?? ""}/"
                                                  "${snapShot.data?[position].reservation_name ?? ""}/"
                                                  "${snapShot.data?[position].reservation_etc ?? ""}"
                                              .text
                                              .maxLines(1)
                                              .ellipsis
                                              .color(AppColors.black)
                                              .size(10)
                                              .make(),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: IconButton(
                                onPressed: () {
                                  navigate(context, ContentDetail.route,
                                      isRootNavigator: false,
                                      arguments: {
                                        "path":
                                            "마이페이지 > 리뷰관리 > ${snapShot.data?[position].content_title}",
                                        "contentIdx":
                                            "${snapShot.data?[position].content_idx}"
                                      });
                                },
                                icon: const Icon(
                                  Icons.arrow_circle_right_rounded,
                                  color: AppColors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                        height20,
                        GestureDetector(
                          onTap: () {
                            navigate(context, CommunityResister.routeOnMyPage,
                                isRootNavigator: false, arguments: {});
                          },
                          child: Container(
                            width: 150,
                            height: 30,
                            decoration: BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: "리뷰 작성하기"
                                    .text
                                    .color(AppColors.white)
                                    .size(10)
                                    .bold
                                    .make()),
                          ),
                        ),
                        height20
                      ],
                    )).pSymmetric(h: 20, v: 10);
              });
        });
  }
}
