import 'package:flutter/material.dart';
import 'package:grip/util/util.dart';
import 'package:grip/util/tap_item.dart';

class MyInfo extends StatefulWidget {
  final Function(TabItem) onButtonClick;

  MyInfo(this.onButtonClick);

  @override
  State createState() => MyInfoState();
}

class MyInfoState extends State<MyInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: buildLoginWidget(),
      ),
    );
  }

  Widget buildLoginWidget() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 30,
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Divider(
            thickness: 2,
            height: 1,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: HexColor.fromHex('#EBEBEB'),
                border:
                    Border.all(width: 0, color: HexColor.fromHex('#EBEBEB')),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: Text(
                  '마이페이지',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Divider(
            thickness: 2,
            height: 1,
            color: Colors.black,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextButton('로그인', () {
              widget.onButtonClick(TabItem.LOGIN);
            }),
            buildTextButton('회원가입', () {
              widget.onButtonClick(TabItem.LOGIN);
            }),
          ],
        )
      ],
    );
  }

  TextButton buildTextButton(String text, VoidCallback callback) {
    return TextButton(
        onPressed: callback,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline),
        ));
  }
}
