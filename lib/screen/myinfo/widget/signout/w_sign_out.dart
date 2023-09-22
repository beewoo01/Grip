import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grip/api/ApiService.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/main.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../common/color/AppColors.dart';
import '../../../../common/widget/w_height_and_width.dart';

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  static const String route = '/edit/signOut';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Line(
              color: AppColors.black,
            ),
            height30,
            "정말 회원 탈퇴하시겠습니까?".text.color(AppColors.black).bold.size(18).make(),
            height30,
            Container(
              width: double.infinity,
              height: 230,
              decoration: const BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: "탈퇴 후 정보 처리 방침등의 내용"
                    .text
                    .color(AppColors.black)
                    .size(15)
                    .make(),
              ),
            ).pSymmetric(h: 20),
            height30,
            TextButton(
              onPressed: () {
                signOut(context);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.white),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
                  side: MaterialStateProperty.all(
                      const BorderSide(color: AppColors.black, width: 1.0))),
              child: "회원탈퇴".text.color(AppColors.black).size(15).make(),
            )
          ],
        ),
      ),
    );
  }

  void signOut(BuildContext context) async {
    ApiService apiService = ApiService();
    int outStatus =
        await apiService.deleteAccount(Singleton().getAccountIdx()) ?? 0;
    if (outStatus > 0) {
      showMessage("회원탈퇴에 성공했습니다.");
      Singleton().setAccountIdx(0);
      Singleton().setAccountName("");
      Navigator.pop(context);
    } else {
      showMessage("회원탈퇴에 실패했습니다.");
    }
  }

  void showMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.black,
        textColor: AppColors.black,
        fontSize: 16.0);
  }

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.black,
          )),
      title: "회원탈퇴"
          .text
          .color(AppColors.black)
          .size(ContextExtention.appbarTitleSize)
          .make(),
    );
  }
}
