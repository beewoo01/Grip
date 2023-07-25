import 'package:flutter/material.dart';

class PromotionDetail extends StatelessWidget {
  final int index;

  PromotionDetail(this.index);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: PromotionDetailSfw(this.index),
    );
  }
}

class PromotionDetailSfw extends StatefulWidget {
  final int index;

  PromotionDetailSfw(this.index);

  @override
  State createState() => _PromotionDetailSfw();
}

class _PromotionDetailSfw extends State<PromotionDetailSfw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppbar(''),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            Divider(
              thickness: 2,
              height: 2,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.centerLeft,
                child: Text(
                  '프로모션 > 상세페이지',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Divider(
              thickness: 2,
              height: 1,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '제목을 입력하세요',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                textAlign: TextAlign.center,
                'GRIP의 프로모션 상세페이지\n이 페이지에 대한 내용을 작성해주세요',
                style: TextStyle(fontSize: 13),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                '당첨자 발표',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Text(
              '해당 이벤트에 참여해주신 모든 분께 감사드립니다.\n당첨되신 분께는 개별 안내드릴 예정입니다.',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '5월 개인 프로필 퐐영 50% 할인 (1명)\n000094s@naver.com (0*0님)',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                width: double.infinity,
                height: 150,
                color: Colors.black,
              ),
            )
          ],
        ),
      )),
    );
  }

  AppBar buildAppbar(String title) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.chevron_left)),
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
        ));
  }
}
