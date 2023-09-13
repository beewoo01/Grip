import 'package:flutter/material.dart';
import 'package:grip/common/image/grip_image.dart';

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
          },
          child: Center(
            child: SizedBox(
              width: width,
              height: double.infinity,
              child: context.buildImage(list[index].content_img_url,
                  fit: BoxFit.fitHeight),
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
