import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/screen/category/reservation_viewmodel.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../common/widget/w_height_and_width.dart';

class ReservationHistory extends StatefulWidget {
  const ReservationHistory({super.key});

  static const String route = '/myinfo/f_reservation';

  @override
  State<ReservationHistory> createState() => _ReservationHistoryState();
}

class _ReservationHistoryState extends State<ReservationHistory>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ReservationViewModel viewModel = ReservationViewModel();

  int selectedPosition = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: buildToolbar(context),
      body: Column(
        children: [
          const Line(
            height: 1,
          ),
          height10,
          Align(
            alignment: Alignment.centerLeft,
            child: "마이페이지 > 예약내역".text.color(AppColors.black).size(15).make(),
          ).pOnly(left: 10),
          height10,
          const Line(
            height: 1,
          ),
          height20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedPosition = 0;
                      });
                    },
                    style: buildTextButtonStyle(0, 10, 0, 10, 0),
                    child: "사진작가"
                        .text
                        .color(selectedPosition == 0
                            ? AppColors.black
                            : AppColors.white)
                        .bold
                        .make()),
              ),
              SizedBox(
                      width: 100,
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectedPosition = 1;
                              print("111");
                            });
                          },
                          style: buildTextButtonStyle(1, 0, 0, 0, 0),
                          child: "장소대여"
                              .text
                              .color(selectedPosition == 1
                                  ? AppColors.black
                                  : AppColors.white)
                              .bold
                              .make()))
                  .pOnly(left: 1, right: 1),
              SizedBox(
                  width: 100,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedPosition = 2;
                          print("222");
                        });
                      },
                      style: buildTextButtonStyle(2, 0, 10, 0, 10),
                      child: "모델"
                          .text
                          .color(selectedPosition == 2
                              ? AppColors.black
                              : AppColors.white)
                          .bold
                          .make())),
            ],
          )
        ],
      ),
    );
  }

  ButtonStyle buildTextButtonStyle(
      int position,
      double topLeftRadius,
      double topRightRadius,
      double bottomLeftRadius,
      double bottomRightRadius) {
    return ButtonStyle(
        backgroundColor: position == selectedPosition
            ? MaterialStateProperty.all(AppColors.white)
            : MaterialStateProperty.all(AppColors.black),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius),
          topRight: Radius.circular(topRightRadius),
          bottomLeft: Radius.circular(bottomLeftRadius),
          bottomRight: Radius.circular(bottomRightRadius),
        ))),
        side: MaterialStateProperty.all(
            const BorderSide(color: AppColors.black, width: 1.0)));
  }

  AppBar buildToolbar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
          )),
      title: "예약내역".text.color(AppColors.black).make(),
    );
  }
}
