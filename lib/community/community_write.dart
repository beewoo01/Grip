import 'package:flutter/material.dart';
import 'package:grip/util/util.dart';

class CommunityWrite extends StatefulWidget {
  const CommunityWrite({super.key});

  @override
  State createState() => CommunityWriteState();
}


class CommunityWriteState extends State<CommunityWrite> {

  List<int> photoList = [];
  List<String> typeDropdownList = ['사진리뷰', '문의하기'];
  List<String> photoDetailTypeDropdownList = ['상품 이용 내역 리스트업', '카테고리 리스트업'];
  List<String> inquiryDetailTypeDropdownList = ['상품 이용 내역 리스트업', '카테고리 리스트업'];
  String selectedTypeDropDown = '사진리뷰';
  String selectedDetailDropDown = '상품 이용 내역 리스트업';


  @override
  Widget build(BuildContext context) {
    return Material(child: Container(
      child: Column(
        children: [
          //buildAppbar(),
          Divider(
            thickness: 1,
            height: 1,
            color: Colors.black,
          ),
          Padding(
            padding:
            EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
            child: buildTextField(13, 16.0, '제목을 입력해주세요.'),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: 10, right: 10, top: 5, bottom: 10),
              child: Container(
                height: 80,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: buildOpenCameraContainer(),
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: buildPhotoList(),
                        ))
                  ],
                ),
              )),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: buildDropdownButton(
                (200), selectedTypeDropDown, typeDropdownList, 0),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: buildDropdownButton(double.infinity,
                selectedDetailDropDown, photoDetailTypeDropdownList,
                1),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 10),
              child: buildLongTextField()),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: buildResisterButton(),
          )
        ],
      ),
    ),);
  }


  Widget buildResisterButton() {
    return TextButton(
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text(
          '게시글 등록',
          style: TextStyle(color: Colors.white),
        ),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all(Colors.black)),
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
                offset: Offset(0, 2))
          ]),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 8,
        maxLength: 8 * 22,
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.transparent,
            isDense: true,
            hintText: '내용을 입력해주세요.'),
      ),
    );
  }

  Widget buildDropdownButton(double width, String value, List<String> list,
      int dropBoxStatus) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
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
                  offset: Offset(0, 2))
            ]),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: DropdownButton(
            underline: SizedBox(),
            isExpanded: true,
            value: value,
            items: list.map((String item) {
              return DropdownMenuItem<String>(
                child: Text('$item'),
                value: item,
              );
            }).toList(),
            onChanged: (dynamic value) {
              setState(() {
                if (dropBoxStatus == 0) {
                  selectedTypeDropDown = value;
                } else {
                  selectedDetailDropDown = value;
                }
              });
            },
          ),
        ),
      ),
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
                padding: EdgeInsets.only(left: 3, right: 3),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      photoList.removeAt(position);
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
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
                            child: Padding(
                                padding: EdgeInsets.all(3),
                                child: Image.asset(
                                    'assets/images/close_icon.png')),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(3.0),
                                border: Border.all(width: 0.0)),
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
                offset: Offset(0, 2))
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
                  offset: Offset(0, 2))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 0.8,
              child: Icon(Icons.settings),
            ),
            Text(
              '${photoList.length}/10',
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(double padding, double radius, String hint) {
    return Container(
      child: TextField(
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
      decoration: BoxDecoration(
          color: HexColor.fromHex("#EBEBEB"),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 0.0, color: HexColor.fromHex("#EBEBEB")),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 2))
          ]),
    );
  }
}