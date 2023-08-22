import 'package:flutter/material.dart';
import 'package:grip/myinfo/account_repository.dart';
import 'package:grip/util/util.dart';
import 'package:provider/provider.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<StatefulWidget> createState() => ReservationState();
  static const String route = '/promotion/reservation';
}

class ReservationState extends State<Reservation> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: buildTextField('이름', '이용자 본인의 이름을 입력하세요'),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      buildTextField('예약일자', ''),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0x85000000),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '예약 날짜 선택 클릭하기 Click',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child:
                    buildFilmContainer('촬영시작시간', '촬영 시작 시간을 선택해주세요', '촬영 박스', [
                  '07:00 ~ 08:00',
                  '08:00 ~ 09:00',
                  '09:00 ~ 10:00',
                  '10:00 ~ 11:00',
                  '11:00 ~ 12:00'
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child:
                    buildFilmContainer('촬영종료시간', '촬영 종료 시간을 선택해주세요', '촬영 박스', [
                  '07:00 ~ 08:00',
                  '08:00 ~ 09:00',
                  '09:00 ~ 10:00',
                  '10:00 ~ 11:00',
                  '11:00 ~ 12:00'
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildTextField('이메일', '@까지 정확하게 입력해주세요'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildTextField('휴대전화번호', '- 없이 휴대전화번호만 입력하세요'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildQuestion(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: OutlinedButton(
                  onPressed: () {
                    //navigate(context, Reservation.route, isRootNavigator: false);

                  },
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      side: const BorderSide(color: Colors.black, width: 0.8)),
                  child: const Text(
                    '예약하기',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 100))
            ],
          ),
        ));
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
      leadingWidth: 100,
      leading: Container(
        alignment: Alignment.center,
        child: const Text(
          '예약하기',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Widget buildQuestion() {
    return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
            color: HexColor.fromHex("#EBEBEB"),
            border: Border.all(color: HexColor.fromHex("#EBEBEB"), width: 0.0),
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 2))
            ]),
        child: const Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    '추가문의',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                )),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              maxLength: 8 * 22,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                  isDense: true,
                  hintText: '내용을 입력해주세요.'),
              style: TextStyle(fontSize: 12),
            ),
          ],
        ));
  }

  Widget buildFilmContainer(
      String title, String text, String value, List<String> items) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10, top: 10),
                child: DropdownButton(
                  underline: const SizedBox(),
                  isExpanded: true,
                  value: '07:00 ~ 08:00',
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text('$item'),
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    setState(() {
                      /*if (dropBoxStatus == 0) {
                      selectedTypeDropDown = value;
                    } else {
                      selectedDetailDropDown = value;
                    }*/
                    });
                  },
                )),
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
}
