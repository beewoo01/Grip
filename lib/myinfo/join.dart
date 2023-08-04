import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/util/util.dart';

class Join extends StatefulWidget {
  const Join({super.key});

  @override
  State<StatefulWidget> createState() => JoinState();
  static const String route = '/myinfo/join';
}

class JoinState extends State<Join> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: buildJoinTitle(),
            ),
            buildDivider(),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: buildTextField('이메일', '@까지 정확하게 입력하세요'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: buildTextField('이름', '이용자 본인의 이름을 입력하세요'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: buildTextField('비밀번호', '비밀번호를 입력하세요'),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: buildIconText('영문'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: buildIconText('숫자'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: buildIconText('특수문자'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: buildIconText('8자 이상 20자 이하'),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: buildTextField('비밀번호 확인', '비밀번호를 다시 입력하세요'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: buildSSNTextField(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: buildPhoneContainer(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: buildExpansion(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 100),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    side: const BorderSide(color: Colors.black, width: 0.8)),
                child: const Text(
                  '회원가입',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpansion() {
    return ExpansionTile(
      collapsedBackgroundColor: HexColor.fromHex('#BEBEBE'),
      maintainState: true,
      title:  const Text('사용자 약관 전체 동의', style: TextStyle(fontSize: 12),),

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

  Widget buildPhoneContainer() {
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
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: TextField(
            style: TextStyle(fontSize: 12),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: '- 없이 휴대전화번호만 입력하세요',
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.3),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.3),
                ),
                contentPadding: EdgeInsets.all(5)),
          ),
        )
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
            style: const TextStyle(color: Colors.black, fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget buildSSNTextField() {
    return Container(
      height: 70,
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
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        counterText: '',
                        contentPadding: EdgeInsets.all(10)),
                  ),
                ),
                Text(
                  '-',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Expanded(
                  flex: 4,
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    maxLength: 7,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        counterText: '',
                        contentPadding: EdgeInsets.all(10)),
                  ),
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

  Widget buildTextField(String name, String hint) {
    return Container(
      height: 60,
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
                    borderSide: BorderSide(color: Colors.black, width: 0.3),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 0.3),
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
      backgroundColor: Colors.white,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Divider(
          thickness: 1,
          height: 1,
          color: Colors.black,
        ),
      ),
      leading: Container(
        alignment: Alignment.center,
        child: const Text(
          'GRIP',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
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
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
        Text(
          '회원가입',
          style: TextStyle(fontSize: 17, color: Colors.black),
        )
      ],
    );
  }

  Divider buildDivider() {
    return const Divider(
      thickness: 1,
      height: 1,
      color: Colors.black,
    );
  }
}
