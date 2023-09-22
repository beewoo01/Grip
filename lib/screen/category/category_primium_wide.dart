import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_container_image.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/screen/category/vo/vo_category_content.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../main.dart';
import '../../model/content_model.dart';
import 'category_viewmodel.dart';
import 'content_detail.dart';

class CategoryWideBody extends StatelessWidget {
  final CategoryViewModel viewModel;
  final String categoryName;

  const CategoryWideBody(this.categoryName,
      {super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      color: AppColors.black,
      child: Column(
        children: [
          height10,
          Container(
                  alignment: Alignment.centerLeft,
                  child: "GRIP 프리미엄 pro"
                      .text
                      .color(AppColors.white)
                      .bold
                      .size(16)
                      .make())
              .pOnly(left: 10),
          height10,
          SizedBox(
            width: double.infinity,
            height: 300,
            child: buildList(),
          )
        ],
      ),
    );
  }

  Widget buildList() {
    return FutureBuilder(
        future: viewModel.selectPremium(Singleton().getAccountIdx()),
        builder: (builder, snapShot) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapShot.data?.length,
            itemBuilder: (BuildContext context, int position) {
              return GestureDetector(
                  onTap: () {
                    navigate(context, ContentDetail.route,
                        isRootNavigator: false,
                        arguments: {
                          'root':
                              '$categoryName > ${snapShot.data?[position].content_title}',
                          'content_idx': snapShot.data?[position].content_idx
                        });
                  },
                  child: Container(
                    width: 230,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(width: 2.0)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        children: [
                          Flexible(
                            flex: 3,
                            child: Container(
                              height: double.infinity,
                              color: Colors.grey,
                              child: ContainerImageWidget(
                                  double.infinity,
                                  double.infinity,
                                  "${snapShot.data?[position].content_img_url}"),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              color: AppColors.white,
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: snapShot
                                        .data?[position].content_title.text.bold
                                        .make(),
                                  ).pOnly(left: 10),
                                  SizedBox(
                                    width: double.infinity,
                                    child: snapShot.data?[position]
                                        .content_description.text.bold
                                        .make(),
                                  ).pOnly(left: 10)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ).pSymmetric(h: 10, v: 10));
            },
          );
        });
  }
}
