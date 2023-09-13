import 'package:flutter/material.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_separator_container.dart';

import '../../screen/home/vo/vo_wedding.dart';

class TestWidget extends StatelessWidget {
  final List<WeddingVO> list;
  final double width;
  final double height;

  const TestWidget(this.list, this.width, this.height, {super.key});

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
              height: height,
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
