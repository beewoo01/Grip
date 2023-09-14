import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../common/widget/w_height_and_width.dart';

class AlarmFragment extends StatefulWidget {
  const AlarmFragment({super.key});

  static const String route = '/myinfo/f_alarm';

  @override
  State<AlarmFragment> createState() => _AlarmFragmentState();
}

class _AlarmFragmentState extends State<AlarmFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          height30,
          buildAlarm(() {
            myInfoKey.currentState!.pop();
          }, () {}),
          const Line(
            height: 1,
          ),
          height20,
          buildContentContainer("예약문의", 2, () {}),
          height30,
          height30,
          height30,
          buildContentContainer("이용후기", 2, () {}),
          height30,
          height30,
          height30,
          buildContentContainer("질문&답변", 2, () {}),
        ],
      ),
    );
  }

  Widget buildAlarm(VoidCallback backCallback, VoidCallback alarmCallback) {
    return Container(
        alignment: Alignment.center,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: backCallback,
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            IconButton(
              onPressed: alarmCallback,
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ],
        ));
  }

  Widget buildContentContainer(String title, int count, VoidCallback callback) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        )]
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: title.text.bold.color(AppColors.black).make()),

          Align(
            alignment: Alignment.centerRight,
            child: "$count건"
                .text
                .bold
                .underline
                .size(8)
                .color(AppColors.black)
                .make(),
          ).pOnly(right: 20)
        ],
      ),
    ).pSymmetric(h: 30);
  }
}
