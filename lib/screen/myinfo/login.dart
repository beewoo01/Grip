import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/widget/drawer/drawer.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/main.dart';
import 'package:grip/screen/myinfo/account_repository.dart';
import 'package:grip/screen/myinfo/find_account.dart';
import 'package:grip/screen/myinfo/join.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import 'vo/vo_account.dart';

class Login extends StatefulWidget {
  static const String route = '/Login';
  bool isCategoryRoot;

  Login({super.key, this.isCategoryRoot = false});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pswController = TextEditingController();
  AccountRepository accountRepository = AccountRepository();

  @override
  Widget build(BuildContext context) {
    print("LoginState build");
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            height20,
            "L O G I N".text.bold.size(25).color(AppColors.black).make(),
            "로그인".text.size(17).color(AppColors.black).make(),
            height20,
            const Line(
              height: 1,
              color: AppColors.black,
            ),
            height30,
            TextField(
              controller: emailController,
              maxLines: 1,
              maxLength: 20,
              decoration: buildTextFieldDecoration("이메일 아이디"),
            ).pSymmetric(h: 30),
            height10,
            TextField(
              controller: pswController,
              obscureText: true,
              maxLength: 20,
              maxLines: 1,
              decoration: buildTextFieldDecoration("비밀번호"),
            ).pSymmetric(h: 30),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    navigate(context, FindAccount.route,
                        isRootNavigator: false, arguments: {});
                  },
                  child: "아이디/비밀번호 찾기"
                      .text
                      .color(AppColors.black)
                      .size(12)
                      .make()),
            ).pOnly(right: 30),
            height20,
            OutlinedButton(
              onPressed: () {
                emailController.text = "test1@test.com";
                pswController.text = "1111";
                String email = emailController.text.toString();
                String psw = pswController.text.toString();
                login(email, psw);
              },
              style: buildOutlineButtonStyle(Colors.white),
              child: "로그인".text.color(AppColors.black).size(20).make(),
            ).pSymmetric(h: 30),
            height10,
            OutlinedButton(
                    onPressed: () {
                      navigate(context, Join.route,
                          isRootNavigator: false, arguments: {});
                    },
                    style: buildOutlineButtonStyle(AppColors.black),
                    child: "회원가입".text.color(AppColors.white).size(20).make())
                .pSymmetric(h: 30),
          ],
        ),
      ),
    );
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void login(String email, String password) async {
    hideKeyboard();
    if (email.length < 4) {
      showToast("이메일을 정확하게 입력해주세요.");
      return;
    }

    if (password.length < 4) {
      showToast("비밀번호를 정확하게 입력해주세요.");
      return;
    }

    int result = await accountRepository.login(email, password);

    if (result > 0) {
      AccountVO? accountVO =
          await accountRepository.getAccountInfo(email, password);

      if (accountVO != null) {
        setState(() {
          Singleton().setAccountIdx(accountVO.account_idx);
          Singleton().setAccountName(accountVO.account_name);
          //myInfoKey.currentState!.pop();
          //navigate(context, route)
          if(widget.isCategoryRoot) {
            Navigator.of(context).pop();
          } else {
            myInfoKey.currentState!.pushReplacementNamed("/");
          }


          //widget.voidCallback();
        });

        showToast("로그인을 성공했습니다.");
      } else {
        showToast("로그인에 실패하셨습니다.");
      }
    } else {
      showToast("로그인에 실패하셨습니다.");
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  ButtonStyle buildOutlineButtonStyle(Color backgroundColor) {
    return OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        side: const BorderSide(color: AppColors.black, width: 0.8));
  }

  InputDecoration buildTextFieldDecoration(String hint) {
    return InputDecoration(
        filled: true,
        counterText: "",
        fillColor: AppColors.grey,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(width: 0.0, color: AppColors.grey)),
        hintText: hint,
        isDense: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(width: 0.0, color: AppColors.grey)),
        contentPadding: const EdgeInsets.all(15));
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
      title: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 30,
            child: Image.asset("assets/images/app_logo.png"),
          ),
        ],
      ),
      actions: [
        Visibility(
          visible: !widget.isCategoryRoot,
          child: IconButton(
              onPressed: (){
                navigate(context, DrawerWidget.route,
                    isRootNavigator: false);
              },
              icon: Image.asset("assets/images/category_ic.png"))
        )
      ],
      automaticallyImplyLeading: false,
    );
  }
}
