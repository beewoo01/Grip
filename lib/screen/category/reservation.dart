import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/screen/category/reservation_viewmodel.dart';
import 'package:grip/screen/category/table_calendar_screen.dart';
import 'package:grip/util/Singleton.dart';
import 'package:grip/util/util.dart';

import '../../model/reservation_model.dart';

class Reservation extends StatefulWidget {
  int contentIdx;

  Singleton singleton = Singleton();

  Reservation({super.key, required this.contentIdx});

  @override
  State<StatefulWidget> createState() => ReservationState(contentIdx: contentIdx);
  static const String route = '/promotion/reservation';
}

class ReservationState extends State<Reservation> {
  int contentIdx;

  ReservationState({required this.contentIdx});

  TextEditingController textEditingController = TextEditingController();
  DateTime? selectedDay;
  bool isTransparent = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController etcController = TextEditingController();
  var startDateStr = '07:00 ~ 08:00';
  var endDateStr = '07:00 ~ 08:00';

  @override
  void initState() {
    super.initState();
    print('ReservationState initState');
  }

  @override
  Widget build(BuildContext context) {
    ReservationViewModel viewModel = ReservationViewModel();

    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child:
                    buildTextField('이름', '이용자 본인의 이름을 입력하세요', nameController),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      buildTextField('예약일자', '', textEditingController),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 65,
                          decoration: BoxDecoration(
                            color: isTransparent
                                ? Colors.transparent
                                : const Color(0x85000000),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '예약 날짜 선택 클릭하기 Click',
                            style: TextStyle(
                                color: isTransparent
                                    ? Colors.transparent
                                    : AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        onTap: () async {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TableCalendarScreen()))
                              .then((value) => {
                                    if (value != null)
                                      {
                                        setState(() {
                                          isTransparent = true;
                                          setReservationDate(value);
                                        })
                                      }
                                    else
                                      {isTransparent = false}
                                  });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const TableCalendarScreen()));
                        },
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildFilmContainer(
                    '촬영시작시간',
                    [
                      '07:00 ~ 08:00',
                      '08:00 ~ 09:00',
                      '09:00 ~ 10:00',
                      '10:00 ~ 11:00',
                      '11:00 ~ 12:00'
                    ],
                    true),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildFilmContainer(
                    '촬영종료시간',
                    [
                      '07:00 ~ 08:00',
                      '08:00 ~ 09:00',
                      '09:00 ~ 10:00',
                      '10:00 ~ 11:00',
                      '11:00 ~ 12:00'
                    ],
                    false),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child:
                    buildTextField('이메일', '@까지 정확하게 입력해주세요', emailController),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildTextField(
                    '휴대전화번호', '- 없이 휴대전화번호만 입력하세요', phoneController),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildQuestion(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: OutlinedButton(
                  onPressed: () async {
                    widget.singleton.setAccountIdx(2);
                    int? accountIdx = widget.singleton.getAccountIdx();

                    if (accountIdx == null) {
                      showToast('로그인을 해주세요.');
                    }

                    if (nameController.text.toString().isEmpty) {
                      showToast('이름을 입력해주세요.');
                    } else if (textEditingController.text.isEmpty) {
                      showToast('예약일자를 선택해주세요.');
                    } else if (emailController.text.isEmpty) {
                      showToast('이메일을 입력해주세요.');
                    } else if (phoneController.text.isEmpty) {
                      showToast('전화번호를 입력해주세요.');
                    } else {
                      reservation(viewModel);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      side: const BorderSide(color: AppColors.black, width: 0.8)),
                  child: const Text(
                    '예약하기',
                    style: TextStyle(color: AppColors.black, fontSize: 20),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 100))
            ],
          ),
        ));
  }

  void reservation(ReservationViewModel viewModel) async {
    final model = ReservationModel.withOutReservationIdx(
        widget.singleton.getAccountIdx()!,
        contentIdx,
        nameController.text,
        textEditingController.text,
        startDateStr,
        endDateStr,
        phoneController.text,
        emailController.text,
        etcController.text);

    final result = await viewModel.insertReservation(model);

    if (result != null) {
      if (result > 0) {
        showMessage('예약이 완료 되었습니다.');
        Navigator.of(context).pop();
      } else {
        showMessage('예약이 실패 되었습니다.');
      }
    } else {
      print('viewModel.insertReservationResult == null');
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.black,
        textColor: AppColors.black,
        fontSize: 16.0);
  }

  void insertReservation(ReservationViewModel viewModel) {}

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

  void setReservationDate(DateTime value) {
    String day = '${value.year}.${value.month}.${value.day}';
    print(day);
    textEditingController.text = day;
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
      leadingWidth: 100,
      leading: Container(
        alignment: Alignment.center,
        child: const Text(
          '예약하기',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.black),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.close,
            color: AppColors.black,
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
        height: 240,
        decoration: BoxDecoration(
            color: HexColor.fromHex("#EBEBEB"),
            border: Border.all(color: HexColor.fromHex("#EBEBEB"), width: 0.0),
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: [
              BoxShadow(
                  color: AppColors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 2))
            ]),
        child: Column(
          children: [
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    '추가문의',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                )),
            TextField(
              controller: etcController,
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              maxLength: 8 * 22,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                  isDense: true,
                  hintText: '내용을 입력해주세요.'),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ));
  }

  Widget buildFilmContainer(String title, List<String> items, bool isStart) {
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
                  value: isStart ? startDateStr : endDateStr,
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    setState(() {
                      if (isStart) {
                        startDateStr = value;
                      } else {
                        endDateStr = value;
                      }
                    });
                  },
                )),
          )
        ],
      ),
    );
  }

  Widget buildTextField(
      String name, String hint, TextEditingController? controller) {
    return GestureDetector(
      child: Container(
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
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: TextField(
                controller: controller,
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
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const TableCalendarScreen()));
      },
    );
  }
}
