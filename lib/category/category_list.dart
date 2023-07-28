import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {

  @override
  State createState() => CategoryState();
}

class CategoryState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:
            ListView.builder(itemBuilder: (BuildContext context, int position) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Container(width: 300, height: 200, color: Colors.black),
          );
        }),
        width: 300,
        height: 200,
      ),
    );
  }
}
