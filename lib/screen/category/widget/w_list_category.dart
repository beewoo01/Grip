import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grip/common/widget/w_container_image.dart';
import 'package:grip/screen/category/category_viewmodel.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/color/AppColors.dart';
import '../../../main.dart';
import '../content_detail.dart';

class CategoryListWidget extends StatelessWidget {
  final CategoryViewModel viewModel;
  final String categoryName;

  const CategoryListWidget(this.viewModel, this.categoryName, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              navigate(context, ContentDetail.route,
                  isRootNavigator: false,
                  arguments: {
                    'root':
                        '$categoryName > ${viewModel.contentList[index].content_title}',
                    'content_idx': viewModel.contentList[index].content_idx
                  });
            },
            child: Container(
              width: 300,
              height: 270,
              decoration:
                  const BoxDecoration(color: AppColors.white, boxShadow: [
                BoxShadow(
                    color: AppColors.black,
                    offset: Offset(1, 1),
                    blurRadius: 0.1,
                    spreadRadius: 0.0)
              ]),
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Column(
                        children: [
                          ContainerImageWidget(double.infinity, 200,
                                  viewModel.contentList[index].content_img_url)
                              .pOnly(top: 10, left: 10, right: 10),
                          Center(
                            child: viewModel
                                .contentList[index].content_title.text
                                .make()
                                .pSymmetric(v: 10),
                          )
                        ],
                      )),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border_outlined)),
                  )
                ],
              ),
            ),
          ).pSymmetric(h: 20, v: 10);
        },
        childCount: viewModel.contentList.length,
      ),
    );
  }
}
