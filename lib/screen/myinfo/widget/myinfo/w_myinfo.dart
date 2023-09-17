import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/screen/myinfo/widget/myinfo/reservation/f_reservation_history.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../main.dart';
import '../../alarm/fragment/f_alarm.dart';
import '../../login.dart';

class MyInfoWidget extends StatefulWidget {
  const MyInfoWidget({super.key});

  static const String route = '/';

  @override
  State<MyInfoWidget> createState() => _MyInfoWidgetState();
}

class _MyInfoWidgetState extends State<MyInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height30,
        buildAppbar(() {
          navigate(context, "/");
        }, () {
          navigate(context, AlarmFragment.route, isRootNavigator: false);
        }),
        buildMyInfoContainer(),
        height20,
        buildReservation().pSymmetric(h: 20),
        height20,
        buildLabelContainer("취소 환불 내역", () {}),
        height10,
        buildLabelContainer("쿠폰함", () {}),
        height10,
        buildLabelContainer("내 정보 관리", () {}),
        height10,
        buildLabelContainer("찜 목록", () {}),
      ],
    );
  }

  Widget buildAppbar(VoidCallback backCallback, VoidCallback alarmCallback) {
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
              icon: const Icon(Icons.circle_notifications),
            ),
          ],
        ));
  }

  Widget buildMyInfoContainer() {
    return Column(
      children: [
        const Line(
          height: 2,
        ),
        height20,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            width20,
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(width: 1, color: AppColors.black),
              ),
            ),
            width10,
            Expanded(
                child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: "${Singleton().getAccountName()}"
                      .text
                      .bold
                      .size(18)
                      .make(),
                ).pSymmetric(h: 10),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(5),
                          backgroundColor: AppColors.grey),
                      child: "내 정보 관리 >"
                          .text
                          .color(AppColors.black)
                          .size(8)
                          .make()),
                ).pSymmetric(h: 10)
              ],
            ))
          ],
        ),
        height20,
        const Line(
          height: 2,
        )
      ],
    );
  }

  Widget buildReservation() {
    return Column(
      children: [

        Container(
          decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  width10,
                  "예약내역".text.color(AppColors.white).bold.size(20).make(),
                  width10,
                  "2023-02-12".text.color(AppColors.white).bold.size(15).make()
                ],
              ),
              IconButton(
                  onPressed: () {
                    navigate(context, ReservationHistory.route, isRootNavigator: false);
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    color: AppColors.white,
                  ))
            ],
          ).pSymmetric(v: 1),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            border: Border.all(
              width: 1,
              color: AppColors.grey,
            ),
          ),
          child: Row(
            children: [
              width10,
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: "000작가".text.color(AppColors.black).bold.make(),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: "[프로모션] 2월 커플 스냅 촬영"
                        .text
                        .color(AppColors.black)
                        .bold
                        .make(),
                  ),
                  height10,
                  SizedBox(
                    width: double.infinity,
                    child: "2023-02-12 / 2인 / 제주 / 보정0 /..."
                        .text
                        .color(AppColors.black)
                        .maxLines(1)
                        .size(8)
                        .ellipsis
                        .make(),
                  ),
                ],
              ).pSymmetric(h: 10))
            ],
          ).pSymmetric(h: 10, v: 20),
        )
      ],
    );
  }

  Widget buildLabelContainer(String text, VoidCallback callback) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Center(
                child: text.text.color(AppColors.black).bold.make(),
              )),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: callback,
              icon: const Icon(Icons.arrow_circle_right_sharp),
            ),
          )
        ],
      ),
    ).pSymmetric(h: 20);
  }
}
