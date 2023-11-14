import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/common/widget/w_default_appbar.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/util/util.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/color/AppColors.dart';

class FindAccount extends StatefulWidget {
  const FindAccount({super.key});

  @override
  State<StatefulWidget> createState() => FindAccountState();
  static const String route = '/myinfo/findAccount';
}

class FindAccountState extends State<FindAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar().createAppbar(callback: () {}),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildLoginTitle().pSymmetric(v: 20),
            buildDivider(),
            height30,
            buildTextField('이름', '').pSymmetric(h: 30),
            height10,
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: buildTextField('주민등록번호', ''),
                ),
                Expanded(
                  flex: 2,
                  child: "-".text.size(25).center.make(),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: HexColor.fromHex('#EBEBEB')),
                          child: const TextField(
                            textAlign: TextAlign.center,
                            showCursor: false,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ),
                      buildDotWidget(),
                      buildDotWidget(),
                      buildDotWidget(),
                      buildDotWidget(),
                      buildDotWidget(),
                      buildDotWidget(),
                    ],
                  ),
                )
              ],
            ).pSymmetric(h: 30),
            height10,
            buildTextField('휴대전화번호', '').pSymmetric(h: 30),
            height30,
            buildJustTextField().pSymmetric(h: 30),
            height20,
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  side: const BorderSide(color: AppColors.black, width: 0.8)),
              child: "인증완료".text.black.size(20).make()

            ).pSymmetric(h: 30),
          ],
        ),
      ),
    );
  }

  Widget buildDotWidget() {
    return const Expanded(
      flex: 1,
      child: Text(
        '●',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  Widget buildJustTextField() {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: HexColor.fromHex('#EBEBEB'),
          borderRadius: BorderRadius.circular(12)),
      child: const TextField(
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: '문자로 받은 인증번호를 입력하세요',
          isDense: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.black, width: 0.3),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.black, width: 0.3),
          ),
        ),
      ).pSymmetric(h: 10),
    );
  }

  Widget buildTextField(String name, String hint) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
          color: HexColor.fromHex('#EBEBEB'),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: TextField(
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                  hintText: hint,
                  isDense: true,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black, width: 0.3),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black, width: 0.3),
                  ),
                  contentPadding: const EdgeInsets.all(5)),
            ),
          )
        ],
      ),
    );
  }

  Widget buildLoginTitle() {
    return const Column(
      children: [
        Text(
          'FIND ID / PW',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: AppColors.black),
        ),
        Text(
          '아이디 / 비밀번호 찾기',
          style: TextStyle(fontSize: 15, color: AppColors.black),
        )
      ],
    );
  }

  Divider buildDivider() {
    return const Divider(
      thickness: 1,
      height: 1,
      color: AppColors.black,
    );
  }
}
