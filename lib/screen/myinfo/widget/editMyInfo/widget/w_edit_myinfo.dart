import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grip/api/ApiService.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/main.dart';
import 'package:grip/screen/myinfo/widget/signout/w_sign_out.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../common/color/AppColors.dart';
import '../../../../../util/number_formatter.dart';

class EditMyInfo extends StatefulWidget {
  const EditMyInfo({super.key});

  static const String route = '/edit';

  @override
  State<EditMyInfo> createState() => _EditMyInfoState();
}

class _EditMyInfoState extends State<EditMyInfo> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController birthEditingController = TextEditingController();

  bool isMail = true;

  @override
  Widget build(BuildContext context) {
    TextField emailTextField = buildTextField(25, TextInputType.emailAddress,
        "이메일을 입력해주세요.", null, emailEditingController);

    TextField phoneTextField = buildTextField(
        13,
        TextInputType.phone,
        "휴대전화번호를 입력해주세요.",
        [
          FilteringTextInputFormatter.digitsOnly,
          PhoneNumberFormatter(),
          LengthLimitingTextInputFormatter(13)
        ],
        phoneEditingController);

    TextField birthTextField = buildTextField(
        10,
        TextInputType.number,
        "yyyy-MM-dd",
        [
          FilteringTextInputFormatter.digitsOnly,
          BirthNumberFormatter(),
          LengthLimitingTextInputFormatter(10)
        ],
        birthEditingController);

    return Scaffold(
      appBar: buildAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //height30,
            const Line(
              height: 1,
              color: AppColors.black,
            ),
            height20,
            Stack(
              children: [
                ClipRRect(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: context.buildImage(""),
                  ),
                ),
                const Positioned(
                    bottom: 1, right: 0, child: Icon(Icons.add_circle))
              ],
            ),
            height10,
            "닉네임".text.size(18).color(AppColors.black).make(),
            height10,
            buildEditBoxWithChangeButton("이메일", emailTextField)
                .pSymmetric(h: 20),
            height10,
            buildEditBoxWithChangeButton("전화", phoneTextField)
                .pSymmetric(h: 20),
            height20,
            Align(
              alignment: Alignment.centerLeft,
              child: "성별"
                  .text
                  .size(12)
                  .color(AppColors.black)
                  .make()
                  .pSymmetric(h: 20),
            ),
            height5,
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMail = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isMail ? AppColors.black : AppColors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          width: 1,
                          color: isMail ? AppColors.white : AppColors.black),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: "남성"
                        .text
                        .color(isMail ? AppColors.white : AppColors.black)
                        .make(),
                  ),
                ),
                width20,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMail = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: !isMail ? AppColors.black : AppColors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          width: 1,
                          color: !isMail ? AppColors.white : AppColors.black),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: "여성"
                        .text
                        .color(!isMail ? AppColors.white : AppColors.black)
                        .make(),
                  ),
                ),
              ],
            ).pSymmetric(h: 20),
            height20,
            Container(
                decoration: const BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    height5,
                    Align(
                            alignment: Alignment.centerLeft,
                            child: "생년월일"
                                .text
                                .color(AppColors.black)
                                .size(12)
                                .make())
                        .pOnly(left: 10),
                    height5,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: birthTextField.pOnly(left: 10)),
                    const Line(
                      height: 1,
                      color: AppColors.black,
                    ).pSymmetric(h: 10),
                    height10,
                  ],
                )).pSymmetric(h: 20),
            height10,
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  navigate(context, SignOut.route,
                      isRootNavigator: false, arguments: {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: AppColors.black),
                  ),
                  padding: const EdgeInsets.all(5),
                  child:
                      "회원탈퇴".text.color(AppColors.black).bold.size(12).make(),
                ),
              ),
            ).pOnly(right: 20),
            height5,
            GestureDetector(
              onTap: () {
                validateCheck(
                    emailTextField.controller?.text.toString() ?? "",
                    phoneTextField.controller?.text.toString() ?? "",
                    birthTextField.controller?.text.toString() ?? "",
                    isMail);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, color: AppColors.black),
                ),
                padding: const EdgeInsets.all(5),
                child: "회원 정보 수정하기".text.color(AppColors.black).size(18).make(),
              ),
            ),

            height20
          ],
        ),
      ),
    );
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

  void validateCheck(String email, String phone, String birth, bool isMale) {
    if (email.trim().length < 5) {
      showMessage("이메일을 정확하게 입력해주세요.");
      return;
    }

    if (phone.trim().length != 13) {
      showMessage("휴대폰 번호를 정확하게 입력해주세요.");
      return;
    }

    if (birth.trim().length != 10) {
      showMessage("생년월일을 정확하게 입력해주세요.");
      return;
    }

    changeMyInfo(email, phone, isMale, birth);
  }

  void changeMyInfo(
      String email, String phone, bool isMale, String birth) async {
    String sBirth = birth.trim();
    sBirth = sBirth.replaceAll("-", "");
    sBirth = sBirth.substring(2);
    String rBirth = "$sBirth-${isMail ? "1" : "2"}";
    String rPhone = phone.trim().replaceAll("-", "");
    print("rBirth is ");
    print("rBirth is $rBirth");

    ApiService apiService = ApiService();

    //apiService.updateUserinfo(email, rBirth, phone, Singleton().getAccountIdx());
    int update =
        await apiService.updateUserinfo(email.trim(), rBirth, rPhone, Singleton().getAccountIdx()) ?? 0;
    switch (update) {
      case -1:
        showMessage("이미 등록된 이메일입니다.");
        break;
      case -2:
        showMessage("이미 등록된 전화번호입니다.");
        break;
      case 0:
        showMessage("업데이트에 실패하였습니다.");
        break;

      default:
        showMessage("업데이트에 성공하였습니다.");
    }
    print("update");
    print(update);
  }

  AppBar buildAppbar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      title: "내 정보 관리".text.color(AppColors.black).size(ContextExtention.appbarTitleSize).make(),
    );
  }

  Widget buildEditBoxWithChangeButton(String title, TextField textField) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      height5,
                      Align(
                          alignment: Alignment.topLeft,
                          child: title.text
                              .color(AppColors.black)
                              .size(12)
                              .make()),
                      height5,
                      SizedBox(
                          width: double.infinity, height: 20, child: textField
                          //buildTextField(maxLength, inputType, hint, inputFormatters),
                          ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: const EdgeInsets.all(5),
                    child:
                        "변경하기".text.color(AppColors.white).bold.size(12).make(),
                  ),
                )
              ],
            ).pSymmetric(h: 5),
          ),
          const Line(
            color: AppColors.black,
          ).pSymmetric(h: 5),
          height10
        ],
      ),
    );
  }

  TextField buildTextField(
      int maxLength,
      TextInputType type,
      String hint,
      List<TextInputFormatter>? inputFormatters,
      TextEditingController controller) {
    return TextField(
        style: const TextStyle(fontSize: 12, color: AppColors.black),
        controller: controller,
        maxLines: 1,
        maxLength: maxLength,
        keyboardType: type,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            isDense: true,
            counterText: '',
            contentPadding: const EdgeInsets.all(5)));
  }

  Widget buildEditContainer(
      String title, TextEditingController controller, String hint) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  title.text.color(AppColors.black).make(),
                  TextField(
                    controller: controller,
                    style: const TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        hintText: hint,
                        isDense: true,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.black, width: 0.3),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.black, width: 0.3),
                        ),
                        contentPadding: const EdgeInsets.all(5)),
                  )
                ],
              ),
              TextButton(
                  onPressed: () {},
                  child: "변경하기".text.color(AppColors.white).make()),
            ],
          )
        ],
      ),
    );
  }
}
