import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grip/api/ApiService.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/util/util.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/widget/w_height_and_width.dart';
import 'account_repository.dart';

class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<StatefulWidget> createState() => JoinState();
  static const String route = '/myinfo/join';
}

class JoinState extends State<Join> {
  AccountRepository accountRepository = AccountRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextField emailTextField =
        makeTextField('@까지 정확하게 입력하세요', 20, TextInputType.emailAddress, false);
    TextField nameTextField =
        makeTextField('이용자 본인의 이름을 입력하세요', 10, TextInputType.name, false);
    TextField passwordTextField =
        makeTextField('비밀번호를 입력하세요', 20, TextInputType.visiblePassword, true);
    TextField passwordConfirmTextField = makeTextField(
        '비밀번호를 다시 입력하세요', 20, TextInputType.visiblePassword, true);
    TextField phoneTextField =
        makeTextField('- 없이 휴대전화번호만 입력하세요', 11, TextInputType.phone, false);
    TextField birthTextField =
        makeIdentifyTextField('', 6, TextInputType.number, false);
    TextField identifyTextField =
        makeIdentifyTextField('', 7, TextInputType.number, true);

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildJoinTitle().pSymmetric(v: 10),
            buildDivider(),
            height30,
            makeTextFieldWidget('이메일', emailTextField).pSymmetric(h: 30),
            height10,
            makeTextFieldWidget('이름', nameTextField).pSymmetric(h: 30),
            height10,
            makeTextFieldWidget('비밀번호', passwordTextField).pSymmetric(h: 30),
            height10,
            Row(
              children: [
                buildIconText('영문').pOnly(left: 10),
                buildIconText('숫자').pOnly(left: 10),
                buildIconText('특수문자').pOnly(left: 10),
                buildIconText('8자 이상 20자 이하').pOnly(left: 10),
              ],
            ).pSymmetric(h: 30),
            height10,
            makeTextFieldWidget('비밀번호 확인', passwordConfirmTextField)
                .pSymmetric(h: 30),
            height10,
            buildSSNTextField(birthTextField, identifyTextField)
                .pSymmetric(h: 30),
            height10,
            buildPhoneContainer(phoneTextField).pSymmetric(h: 30),
            height10,
            buildExpansion().pSymmetric(h: 30),
            height10,
            OutlinedButton(
              onPressed: () {
                print('OutlinedButton');
                String identify =
                    "${birthTextField.controller!.text}-${identifyTextField.controller!.text}";

                join(
                    emailTextField.controller!.text.toString(),
                    nameTextField.controller!.text.toString(),
                    passwordTextField.controller!.text.toString(),
                    passwordConfirmTextField.controller!.text.toString(),
                    identify,
                    phoneTextField.controller!.text.toString(),
                    accountRepository);
                //ApiService().join(email, name, password, identify, phone)
              },
              style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: AppColors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  side: const BorderSide(color: AppColors.black, width: 0.8)),
              child: "회원가입".text.color(AppColors.white).size(20).make(),
            ).pSymmetric(h: 30),
            height30,
            height30,
            height30,
          ],
        ),
      ),
    );
  }

  void onListener(Map<String, dynamic> map) {
    print('changed in Join View');
    if (map["emailState"] == -1) {
      showMessage('이미 가입된 이메일입니다.');
    } else if (map["icnState"] == -1) {
      showMessage('이미 가입된 정보입니다.');
    } else if (map["phoneState"] == -1) {
      showMessage('이미 가입된 휴대폰 번호 입니다.');
    } else {
      showMessage('가입 해야함');
    }
  }

  void join(String email, String name, String password, String passwordConfirm,
      String identify, String phone, AccountRepository viewModel) {
    if (email.length < 10) {
      print('이메일을 올바르게 입력해주세요.');
      showMessage('이메일을 올바르게 입력해주세요.');
    } else if (name.length < 2) {
      print('이름을 올바르게 입력해주세요.');
      showMessage('이름을 올바르게 입력해주세요.');
    } else if (password.length < 4) {
      print('비밀번호를 올바르게 입력해주세요.');
      showMessage('비밀번호를 올바르게 입력해주세요.');
    } else if (password != passwordConfirm) {
      showMessage('비밀번호가 일치하지 않습니다.');
    } else if (identify.length < 13) {
      showMessage('주민등록번호를 올바르게 입력해주세요.');
    } else if (phone.length < 11) {
      print('휴대폰 번호를 올바르게 입력해주세요.');
      showMessage('휴대폰 번호를 올바르게 입력해주세요.');
    } else {
      viewModel.duplicateCheck(email, name, password, identify, phone);

      viewModel.addListener(() {
        if (viewModel.duplicateMap != null) {
          onListener(viewModel.duplicateMap!);
        }
      });
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

  Widget buildExpansion() {
    return ExpansionTile(
      collapsedBackgroundColor: HexColor.fromHex('#BEBEBE'),
      maintainState: true,
      title: const Text(
        '사용자 약관 전체 동의',
        style: TextStyle(fontSize: 12),
      ),

      // backgroundColor: HexColor.fromHex('#EBEBEB') ,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: buildIconText('서비스 이용 약관 동의(필수)'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: buildIconText('개인정보 처리방침 동의(필수)'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: buildIconText('만 14세 이상 확인(필수)'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: buildIconText('쿠폰, 이벤트 등 혜택 알림 동의(선택)'),
            ),
          ],
        )
      ],
    );
  }

  Widget buildIconText(String text) {
    return Row(
      children: [
        const Icon(
          Icons.check_box_sharp,
          size: 10.0,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 10),
        )
      ],
    );
  }

  Widget buildPhoneContainer(TextField textField) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: HexColor.fromHex('#EBEBEB'),
          borderRadius: BorderRadius.circular(12)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '휴대전화번호',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '대한민국 +82',
                style: TextStyle(fontSize: 11),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: buildDivider(),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: textField)
      ]),
    );
  }

  Widget buildCheckBox(String text) {
    return Container(
      height: 18,
      color: Colors.blue,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // 세로 축을 중앙 정렬
        children: [
          Transform.scale(
            scale: 0.8,
            child: Checkbox(
              value: false,
              onChanged: (bool? value) {},
            ),
          ),
          Text(
            text,
            style: const TextStyle(color: AppColors.black, fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget buildSSNTextField(
      TextField birthTextField, TextField identifyTextField) {
    // TextField birthTextField = makeIdentifyTextField('', 6, TextInputType.number, false);
    // TextField identifyTextField = makeIdentifyTextField('', 7, TextInputType.number, true);

    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: HexColor.fromHex('#EBEBEB'),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '주민등록번호',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(flex: 4, child: birthTextField),
                const Text(
                  '-',
                  style: TextStyle(fontSize: 18, color: AppColors.black),
                ),
                Expanded(
                  flex: 4,
                  child: identifyTextField,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: buildDivider(),
          )
        ],
      ),
    );
  }

  TextField makeTextField(
      String hint, int maxLength, TextInputType type, bool obscureText) {
    TextEditingController controller = TextEditingController();
    return TextField(
        style: const TextStyle(fontSize: 10, color: AppColors.black),
        controller: controller,
        maxLines: 1,
        maxLength: maxLength,
        keyboardType: type,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            counterText: '',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.black, width: 0.3),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.black, width: 0.3),
            ),
            contentPadding: const EdgeInsets.all(5)));
  }

  TextField makeIdentifyTextField(
      String hint, int maxLength, TextInputType type, bool obscureText) {
    TextEditingController controller = TextEditingController();
    return TextField(
      textAlign: TextAlign.center,
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 12),
      maxLines: 1,
      maxLength: maxLength,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
    );
  }

  Widget makeTextFieldWidget(String name, TextField textField) {
    //var textField = makeTextField(hint);

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
              child: textField)
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
        child: const Text(
          'GRIP',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black),
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

  Widget buildJoinTitle() {
    return const Column(
      children: [
        Text(
          'JOIN',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: AppColors.black),
        ),
        Text(
          '회원가입',
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
