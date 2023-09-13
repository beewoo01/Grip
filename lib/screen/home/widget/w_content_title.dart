import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/color/AppColors.dart';
import '../../../common/widget/w_height_and_width.dart';

class ContentTitleWidget extends StatelessWidget {
  final String title;
  const ContentTitleWidget(this.title, {super.key});

  final double height = 50;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: Image.asset('assets/images/noimage.png'),
              ),
              width10,
              title.text.size(18).bold.make(),
            ],
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.add, color: AppColors.black,))
        ],
      ),
    );
  }
}
