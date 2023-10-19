import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/url/grip_url.dart';
import 'package:grip/screen/category/category_viewmodel.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/color/AppColors.dart';
import '../../../main.dart';
import '../content_detail.dart';

class GridCategoryWidget extends StatelessWidget {
  final CategoryViewModel viewModel;
  final String categoryName;

  const GridCategoryWidget(this.viewModel, this.categoryName, {super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
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
              color: AppColors.white,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.black,
                                  offset: Offset(1, 1),
                                  blurRadius: 0.1,
                                  spreadRadius: 0.0)
                            ]),
                        child: Column(
                          children: [
                            Expanded(
                              child: context
                                  .buildImage(
                                      viewModel
                                          .contentList[index].content_img_url,
                                      placeholder: (context, url) => Container(
                                            color: Colors.grey,
                                          ),
                                fit: BoxFit.cover
                              )
                                  .pOnly(left: 10, right: 10, top: 5),
                            ),
                            viewModel.contentList[index].content_title.text
                                .make(),
                          ],
                        ),
                      )),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border_outlined)
                          //SvgPicture.asset('assets/images/category.svg'),
                          ))
                ],
              ),
            ),
          ).pSymmetric(v: 10, h: 10);
        }, childCount: viewModel.contentList.length),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2));
  }
}
