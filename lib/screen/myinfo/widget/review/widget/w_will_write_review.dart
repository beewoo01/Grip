import 'package:flutter/material.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
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
        future:
            viewModel.selectPossibleWriteReview(Singleton().getAccountIdx()),
        builder: (builder, snapShot) {
          return ListView.builder(
              itemCount: snapShot.data?.length ?? 0,
              itemBuilder: (BuildContext context, int position) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: AppColors.grey,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                color: AppColors.grey,
                              ),
                              Column(
                                children: [
                                  (snapShot.data?[position].content_title ?? "")
                                      .text
                                      .color(AppColors.black)
                                      .bold
                                      .make(),
                                  (snapShot.data?[position].reservation_name ??
                                          "")
                                      .text
                                      .color(AppColors.black)
                                      .bold
                                      .make(),
                                  height5,
                                  (snapShot.data?[position].reservation_etc ??
                                          "")
                                      .text
                                      .color(AppColors.black)
                                      .make(),
                                ],
                              )
                            ],
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: "리뷰 작성하기"
                                  .text
                                  .color(AppColors.white)
                                  .size(15)
                                  .make(),
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_circle_right),
                          ),
                        ),
                      )
                    ],
                  ),
                ).pSymmetric(h: 20, v: 10);
              });
        });
  }
}
