import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grip/model/pair.dart';
import 'package:grip/model/purchase_model.dart';
import 'package:grip/util/util.dart';
import 'package:grip/main.dart';
import 'package:grip/sample.dart';

import '../util/Singleton.dart';
import 'community_viewmodel.dart';

class CommunityResister extends StatefulWidget {
  const CommunityResister({Key? key}) : super(key: key);

  @override
  State createState() => _CommunityResisterSfw();
  static const String route = '/community/write';
}

class _CommunityResisterSfw extends State<CommunityResister> {
  List<int> photoList = [];
  List<PurchaseModel> typeDropdownList = [
    PurchaseModel(content_idx: 0, content_title: '사진리뷰'),
    PurchaseModel(content_idx: 1, content_title: '문의하기')
  ];
  List<PurchaseModel>? photoDetailTypeDropdownList;
  List<PurchaseModel>? inquiryTypeDropdownList;
  //late String? selectedTypeDropDown = typeDropdownList[0].content_title;
  late Pair<int, String> selectedTypeDropDown = Pair(typeDropdownList[0].content_idx, typeDropdownList[0].content_title);
  Pair<int?, String?>? selectedDetailDropDown;
  //String? selectedDetailDropDown;

  TextEditingController titleEditController = TextEditingController();
  TextEditingController descriptionEditController = TextEditingController();

  var viewModel = CommunityViewModel();

  @override
  void initState() {
    super.initState();
    Singleton().setAccountIdx(2);
    fetchData();
  }

  Future<void> fetchData() async {
    int? accountIdx = Singleton().getAccountIdx();

    if (accountIdx == null || accountIdx == 0) {
      showToast('로그인을 해주세요.');
    } else {
      setState(() async {
        print('_CommunityResisterSfw setState1111');
        List<PurchaseModel>? list =
            await viewModel.selectPurchaseList(accountIdx);

        setState(() {
          print('_CommunityResisterSfw setState2222');
          photoDetailTypeDropdownList = list;
          selectedDetailDropDown = Pair(photoDetailTypeDropdownList?[0].content_idx, photoDetailTypeDropdownList?[0].content_title);
              //photoDetailTypeDropdownList?[0].content_title;
          print('photoDetailTypeDropdownList result');
          print('$photoDetailTypeDropdownList');
        });
      });
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    print('_CommunityResisterSfw build');
    return Material(
      child: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                buildAppbar(),
                const Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 10),
                  child: buildTextField(13, 16.0, '제목을 입력해주세요.'),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 10),
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: buildOpenCameraContainer(),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: buildPhotoList(),
                          ))
                        ],
                      ),
                    )),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  //child: buildDropdownButton((200), selectedTypeDropDown, typeDropdownList, 0),
                  child: buildDropdownButton((200), 0),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: buildDropdownButton(double.infinity, 1),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 10),
                    child: buildLongTextField()),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: buildResisterButton(),
                )
              ],
            )),
      ),
    );
  }

  Widget buildResisterButton() {
    return TextButton(
      onPressed: () {
        String title= titleEditController.text;
        String description = descriptionEditController.text;
        /*int contentIdx =
        if(selectedTypeDropDown.first == 0) {
          viewModel.insertReview();
        }*/

      },
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all(Colors.black)),
      child: const Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text(
          '게시글 등록',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildLongTextField() {
    return Container(
      width: double.infinity,
      height: 250,
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
      child: TextField(
        controller: descriptionEditController,
        keyboardType: TextInputType.multiline,
        maxLines: 8,
        maxLength: 8 * 22,
        decoration: const InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
            isDense: true,
            hintText: '내용을 입력해주세요.'),
      ),
    );
  }

  Widget buildDropdownButton(double width, int dropBoxStatus) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: width,
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
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: dropBoxStatus == 0 ? buildTypeDropdown() : buildDropdown(),

        ),
      ),
    );
  }

  DropdownButton buildTypeDropdown() {
    print('buildTypeDropdown');
    return DropdownButton(
      underline: const SizedBox(),
      isExpanded: true,
      value: selectedTypeDropDown.secend,
      items: typeDropdownList.map((PurchaseModel item) {
        return DropdownMenuItem<String>(
          value: item.content_title,
          child: Text(item.content_title),
        );
      }).toList(),
      onChanged: (dynamic value) {
        print('buildTypeDropdown onChanged value is');
        print(value);
        setState(() {
          selectedTypeDropDown = value;
        });
      },
    );
  }

  DropdownButton buildDropdown() {
    print('buildDropdown');
    return DropdownButton(
      underline: const SizedBox(),
      isExpanded: true,
      value: selectedDetailDropDown?.secend,
      items: photoDetailTypeDropdownList?.map((PurchaseModel item) {
            return DropdownMenuItem<String>(
              value: item.content_title,
              child: Text(item.content_title),
            );
          }).toList() ?? [],
      onChanged: (dynamic value) {
        print('buildDropdown onChanged value is');
        print(value);
        setState(() {
          selectedDetailDropDown = value;
          /*if (dropBoxStatus == 0) {
            selectedTypeDropDown = value;
          } else {
            selectedDetailDropDown = value;
          }*/
        });
      },
    );
  }

  Widget buildPhotoList() {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photoList.length,
            itemBuilder: (BuildContext context, int position) {
              return Padding(
                padding: const EdgeInsets.only(left: 3, right: 3),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      photoList.removeAt(position);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        buildPhotoBox(),
                        Positioned(
                          top: 10,
                          right: 0,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(3.0),
                                border: Border.all(width: 0.0)),
                            child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Image.asset(
                                    'assets/images/close_icon.png')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  Widget buildPhotoBox() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          color: HexColor.fromHex("#EBEBEB"),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 0.0, color: HexColor.fromHex("#EBEBEB")),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 2))
          ]),
    );
  }

  Widget buildOpenCameraContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (photoList.length == 10) {
            return;
          }
          photoList.add(photoList.length + 1);
          //selectedPhotoCount++;
        });
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: HexColor.fromHex("#EBEBEB"),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(width: 0.0, color: HexColor.fromHex("#EBEBEB")),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 2))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 0.8,
              child: SvgPicture.asset('assets/images/camera.svg'),
            ),
            Text(
              '${photoList.length}/10',
              style: const TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(double padding, double radius, String hint) {
    return Container(
      decoration: BoxDecoration(
          color: HexColor.fromHex("#EBEBEB"),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 0.0, color: HexColor.fromHex("#EBEBEB")),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 2))
          ]),
      child: TextField(
        controller: titleEditController,
        decoration: InputDecoration(
            filled: true,
            fillColor: HexColor.fromHex('#EBEBEB'),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide:
                    BorderSide(width: 0.0, color: HexColor.fromHex('#EBEBEB'))),
            hintText: hint,
            isDense: true,
            contentPadding: EdgeInsets.all(padding)),
      ),
    );
  }

  Widget buildAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        '커뮤니티 글쓰기',
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              print('IconButton onPressed');
              Navigator.pop(context);

              //print('IconButton onPressed');
              //Navigator.pop(context);

              /*Navigator.of(context).rou;
              var navigatorState = Navigator.of(context);
              final routes = navigatorState.routes;*/
              //Navigator.of(context).pop();
              //Navigator(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ))
      ],
    );
  }
}
