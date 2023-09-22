import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: buildLoginTitle(),
            ),
            buildDivider(),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: buildTextField('이름', ''),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: buildTextField('주민등록번호', ''),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
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
                          const Expanded(
                            flex: 1,
                            child: Text(
                              '●',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              '●',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              '●',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              '●',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              '●',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              '●',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: buildTextField('휴대전화번호', ''),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: buildJustTextField()),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    side: const BorderSide(color: AppColors.black, width: 0.8)),
                child: const Text(
                  '인증완료',
                  style: TextStyle(color: AppColors.black, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
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
      child: const Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: TextField(
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
        ),
      ),
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

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Divider(
          thickness: 1,
          height: 1,
          color: AppColors.black,
        ),
      ),
      leading: Container(
        alignment: Alignment.center,
        child: "GRIP".text.color(AppColors.black).bold.size(18).make()
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset('assets/images/category.svg'),
          onPressed: () {
            //Navigator.pop(context);
            //Community Write에서 pop을 시키니 여기에서 pop한거와 동일하게 작동함
          },
        )
      ],
    );
  }

  Widget buildLoginTitle() {
    return const Column(
      children: [
        Text(
          'FIND ID / PW',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: AppColors.black),
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
