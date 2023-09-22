import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/screen/myinfo/widget/like/vm/vm_like.dart';
import 'package:grip/screen/myinfo/widget/like/vo/vo_my_like_content.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

class MyLikeContent extends StatefulWidget {
  const MyLikeContent({super.key});


  static const String route = '/myLikeContent';

  @override
  State<MyLikeContent> createState() => _MyLikeContentState();
}

class _MyLikeContentState extends State<MyLikeContent> {
  LikeContentViewModel viewModel = LikeContentViewModel();
  int selectedPosition = 0;
  final double containerSize = 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: Column(
        children: [
          const Line(),
          height10,
          SizedBox(
            width: double.infinity,
            child: "마이페이지 > 찜 목록".text.color(AppColors.black).size(10).make(),
          ).pSymmetric(h: 10),
          height10,
          const Line(),
          height30,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedPosition = 0;
                      });
                    },
                    style: buildTextButtonStyle(0, 10, 0, 10, 0),
                    child: "사진작가"
                        .text
                        .color(selectedPosition == 0
                            ? AppColors.black
                            : AppColors.white)
                        .bold
                        .make()),
              ),
              SizedBox(
                      width: 100,
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectedPosition = 1;
                              print("111");
                            });
                          },
                          style: buildTextButtonStyle(1, 0, 0, 0, 0),
                          child: "장소대여"
                              .text
                              .color(selectedPosition == 1
                                  ? AppColors.black
                                  : AppColors.white)
                              .bold
                              .make()))
                  .pOnly(left: 1, right: 1),
              SizedBox(
                  width: 100,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedPosition = 2;
                          print("222");
                        });
                      },
                      style: buildTextButtonStyle(2, 0, 10, 0, 10),
                      child: "모델"
                          .text
                          .color(selectedPosition == 2
                              ? AppColors.black
                              : AppColors.white)
                          .bold
                          .make())),
            ],
          ),
          height20,
          Expanded(child: buildGridView(selectedPosition + 1))
        ],
      ),
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
            ? MaterialStateProperty.all(AppColors.white)
            : MaterialStateProperty.all(AppColors.black),
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
      title: "찜 목록".text.color(AppColors.black).size(15).make(),
    );
  }

  Widget buildGridView(int categoryIdx) {
    return FutureBuilder(
        future: viewModel.selectMyLike(categoryIdx, Singleton().getAccountIdx()),
        builder: (builder, snapShot) {
          if(snapShot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 200.0,
              width: 200.0,
              child: Center(
                  child: CircularProgressIndicator()
              ),
            );
          }

          print("buildGridView load");
          List<MyLikeContentVO> list = snapShot.data ?? [];
          return GridView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int position) {

              return Column(
                children: [
                  Container(
                    width: containerSize,
                    height: containerSize,
                    decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: context.buildImage(
                                "${list[position].content_img_url}"),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () async {
                                int likeIdx = list[position].like_idx;


                                if (likeIdx > 0) {
                                  int delState = await viewModel.deleteLike(likeIdx);
                                  if(delState > 0){
                                    setState(() {
                                      list.removeAt(position);
                                    });
                                  }

                                }

                              },
                              icon: const Icon(Icons.favorite),
                              color: AppColors.black,
                            ))
                      ],
                    ),
                  ),
                  height10,
                  SizedBox(
                    width: containerSize,
                    child: list[position].content_title
                        .text
                        .color(AppColors.black)
                        .size(8)
                        .maxLines(1)
                        .ellipsis
                        .make(),
                  ),
                  SizedBox(
                    width: containerSize,
                    child: list[position].content_description
                        .text
                        .color(AppColors.black)
                        .size(10)
                        .bold
                        .maxLines(1)
                        .ellipsis
                        .make(),
                  ),
                ],
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4/5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
          );
        });
  }

}
