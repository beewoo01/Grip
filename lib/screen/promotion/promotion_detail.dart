import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/color/AppColors.dart';

class PromotionDetail extends StatefulWidget {
  final int index;

  const PromotionDetail({Key? key, required this.index}) : super(key: key);
  static const String route = '/promotion/detail';

  @override
  State createState() => _PromotionDetailSfw();
}

class _PromotionDetailSfw extends State<PromotionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: buildAppbar(''),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [

            const Divider(
              thickness: 1,
              height: 1,
              color: AppColors.black,
            ),

            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.centerLeft,
              child: "프로모션 > 상세페이지".text.size(12).make(),
            ).pOnly(left: 10),

            const Divider(
              thickness: 1,
              height: 1,
              color: AppColors.black,
            ),

            height10,
            "제목을 입력하세요".text.center.size(20).bold.make(),

            height20,
            "GRIP의 프로모션 상세페이지\n이 페이지에 대한 내용을 작성해주세요".text.size(13).make(),

            Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey,
            ),
            height20,

            "당첨자 발표".text.bold.size(18).make(),

            "해당 이벤트에 참여해주신 모든 분께 감사드립니다.\n당첨되신 분께는 개별 안내드릴 예정입니다."
                .text
                .center
                .make(),

            height10,
            "5월 개인 프로필 퐐영 50% 할인 (1명)\n000094s@naver.com (0*0님)"
                .text
                .center
                .extraBold
                .make(),

            height10,
            Container(
              width: double.infinity,
              height: 150,
              color: AppColors.black,
            )
          ],
        ),
      )),
    );
  }

  AppBar buildAppbar(String title) {
    return AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.chevron_left)),
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            IconButton(
                onPressed: () {},
                icon: Image.asset("assets/images/category_ic.png")),
          ],
        ));
  }
}
