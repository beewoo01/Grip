import 'package:flutter/material.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/screen/myinfo/widget/review/viewModel/vm_review.dart';
import 'package:grip/screen/myinfo/widget/review/widget/w_will_write_review.dart';
import 'package:grip/screen/myinfo/widget/review/widget/w_wrote_review.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../common/color/AppColors.dart';
import '../../../../../common/image/grip_image.dart';

class ReviewManagement extends StatefulWidget {
  const ReviewManagement({super.key});

  static const String route = '/reviewManagement';

  @override
  State<ReviewManagement> createState() => _ReviewManagementState();
}

class _ReviewManagementState extends State<ReviewManagement> {
  ReviewViewModel viewModel = ReviewViewModel();
  int selectedPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: Column(
        children: [
          height20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: buildTextButton(() {
                  setState(() {
                    print("리뷰 작성하기");
                    selectedPosition = 0;
                  });
                }, "리뷰 작성하기", 0, 10, 0, 10, 0),
              ),
              SizedBox(
                width: 150,
                child: buildTextButton(() {
                  print("내가 쓴 리뷰");
                  setState(() {
                    selectedPosition = 1;
                  });
                }, "내가 쓴 리뷰", 1, 0, 10, 0, 10),
              ),
            ],
          ),
          height10,

          Expanded(
            //child: WroteReview(viewModel),
            child: selectedPosition == 0 ? WillWriteReview(viewModel) : WroteReview(viewModel),
          ),

          height30,
          height30,
        ],
      ),
    );
  }

  TextButton buildTextButton(
      VoidCallback callback,
      String title,
      int position,
      double topLeftRadius,
      double topRightRadius,
      double bottomLeftRadius,
      double bottomRightRadius) {
    return TextButton(
      onPressed: callback,
      style: buildTextButtonStyle(
        position,
        topLeftRadius,
        topRightRadius,
        bottomLeftRadius,
        bottomRightRadius,
      ),
      child: title.text
          .color(
              selectedPosition == position ? AppColors.white : AppColors.black)
          .size(15)
          .make(),
    );
  }

  ButtonStyle buildTextButtonStyle(
      int position,
      double topLeftRadius,
      double topRightRadius,
      double bottomLeftRadius,
      double bottomRightRadius) {
    return ButtonStyle(
        backgroundColor: position == selectedPosition
            ? MaterialStateProperty.all(AppColors.black)
            : MaterialStateProperty.all(AppColors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          bottomRight: Radius.circular(bottomRightRadius),
        ))),
        side: MaterialStateProperty.all(
            const BorderSide(color: AppColors.black, width: 1.0)));
  }

  AppBar buildAppbar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.black,
        ),
      ),
      title: "리뷰관리"
          .text
          .color(AppColors.black)
          .size(ContextExtention.appbarTitleSize)
          .make(),
    );
  }
}
