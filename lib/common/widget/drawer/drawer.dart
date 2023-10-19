import 'package:flutter/material.dart';
import 'package:grip/common/widget/drawer/drawer_category_widget.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/main.dart';
import 'package:grip/screen/myinfo/join.dart';
import 'package:grip/screen/myinfo/login.dart';
import 'package:grip/screen/myinfo/my_page.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../color/AppColors.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  static const String route = '/drawer';

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            height30,
            Row(
              children: [
                SizedBox(
                  width: 150,
                  height: 45,
                  child: Image.asset("assets/images/app_logo_footer.png"),
                ),
                Expanded(child: Container()),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ).pSymmetric(h: 20),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: (Singleton().getAccountIdx() > 0
                      ? Singleton().getAccountName() ?? ""
                      : "로그인을 해주세요")
                  .text
                  .color(AppColors.black)
                  .bold
                  .size(13)
                  .make(),
            ).pSymmetric(h: 20),
            height10,
            buildDivider(double.infinity).pSymmetric(h: 20),
            height30,
            buildMainContainer(
                Column(
                  children: [
                    height30,
                    buildBoldText("카테고리", 20),
                    const DrawerCategoryWidget(),
                  ],
                ),
                null),
            buildMainContainer(buildBoldText("프로모션", 20), 60),
            buildMainContainer(
                Column(
                  children: [
                    height10,
                    buildBoldText("커뮤니티", 20),
                    height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTextButton(() {}, "사진리뷰", 16, true),
                        width5,
                        Container(
                          color: Colors.white,
                          width: 2,
                          height: 15,
                        ),
                        width5,
                        buildTextButton(() {}, "문의하기", 18, true)
                      ],
                    ),
                  ],
                ),
                null),
            buildMainContainer(buildTextButton(() {}, "마이페이지", 20, true), null),
            Visibility(
              visible: Singleton().getAccountIdx() <= 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setNotify(NavBarHandler.MY_PAGE);

                          },
                          child: "로그인"
                              .text
                              .underline
                              .color(Colors.black)
                              .size(18)
                              .make()),
                    ],
                  ),
                  Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            navigate(context, Join.route, isRootNavigator: false);

                          },
                          child: "회원가입"
                              .text
                              .underline
                              .color(Colors.black)
                              .size(18)
                              .make()),
                    ],
                  ),
                ],
              ),
            ),
            height30,
            height30,
            height30,
          ],
        ),
      ),
    );
  }

  Widget buildMainContainer(Widget child, double? height) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, AppColors.gradientEndColor])),
      child: child,
    );
  }

  Widget buildTextButton(
      VoidCallback callback, String str, double size, bool isBold) {
    return isBold
        ? TextButton(onPressed: callback, child: buildBoldText(str, size))
        : TextButton(onPressed: callback, child: buildText(str, size));
  }

  Widget buildUnderLineText(String str, double size) {
    return str.text.size(size).underline.color(Colors.black).make();
  }

  Widget buildBoldText(String str, double size) {
    return Center(
        child: str.text.size(size).center.bold.color(Colors.white).make());
  }

  Widget buildText(String str, double size) {
    return str.text.size(size).color(Colors.white).make();
  }

  Widget buildDivider(double width) {
    return Container(
      width: width,
      height: 1,
      color: Colors.black,
    );
  }
}
