import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../common/widget/w_height_and_width.dart';

class ReservationHistory extends StatelessWidget {
  const ReservationHistory({super.key});

  static const String route = '/myinfo/f_reservation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: buildToolbar(context),
      body: const Column(
        children: [
          Line(
            height: 1,
          ),
          
          //"마이페이지 > 예약내역".text.color()

          Line(
            height: 1,
          ),
        ],
      ),
    );
  }


  AppBar buildToolbar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios_new)),
      title: "예약내역".text.color(AppColors.black).make(),
    );
  }
}
