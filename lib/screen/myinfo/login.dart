import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/api/ApiService.dart';
import 'package:grip/main.dart';
import 'package:grip/util/util.dart';

import '../../common/color/AppColors.dart';
import 'find_account.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State createState() => LoginState();
  static const String route = '/myinfo/login';
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildLoginTitle(),
            ),
            buildDivider(),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: buildTextField('이메일 아이디'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: buildTextField('비밀번호'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 30,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    navigate(context, FindAccount.route,
                        isRootNavigator: false, arguments: {});
                  },
                  child: const Text(
                    '아이디/비밀번호 찾기',
                    style: TextStyle(color: AppColors.black, fontSize: 12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: OutlinedButton(
                onPressed: () {
                  ApiService().login('test@test.com', '1234');
                },
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    side: const BorderSide(color: AppColors.black, width: 0.8)),
                child: const Text(
                  '로그인',
                  style: TextStyle(color: AppColors.black, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    side: const BorderSide(color: AppColors.black, width: 0.8)),
                child: const Text(
                  '회원가입',
                  style: TextStyle(color: AppColors.black, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextField buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: HexColor.fromHex('#EBEBEB'),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide:
                  BorderSide(width: 0.0, color: HexColor.fromHex('#EBEBEB'))),
          hintText: hint,
          isDense: true,
          contentPadding: const EdgeInsets.all(15)),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.black,
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
        child: const Text(
          'GRIP',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.black),
        ),
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
          'LOGIN',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: AppColors.black),
        ),
        Text(
          '로그인',
          style: TextStyle(fontSize: 17, color: AppColors.black),
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
