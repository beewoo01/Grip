import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/url/grip_url.dart';
import 'package:grip/common/widget/w_circulator_progress.dart';
import 'package:grip/main.dart';
import 'package:grip/screen/category/content_detail.dart';

import 'package:grip/screen/home/vo/vo_wedding.dart';

import '../../../common/color/AppColors.dart';
import '../../../common/widget/w_separator_container.dart';

class FindModelWidget extends StatelessWidget {
  final List<WeddingVO> list;
  final double width;

  const FindModelWidget(this.list, this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print(list[index].content_img_url);
            print("변경됨");
            navigate(context, ContentDetail.route, isRootNavigator: false, arguments: {
              'root' : list[index].content_title, 'content_idx' : list[index].content_idx
            });
          },
          child: Center(
            child: SizedBox(
                width: width,
                height: double.infinity,
                child: context.buildImage(list[index].content_img_url, fit: BoxFit.cover),
                ),
          ),
        );
      },
      separatorBuilder: (context, index) => separator10,
      itemCount: list.length,
      scrollDirection: Axis.horizontal,
    );
  }
}
