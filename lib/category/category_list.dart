import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: CategoryListSfw(),
    );
  }
}

class CategoryListSfw extends StatefulWidget {
  @override
  State createState() => _CategoryListSfw();
}

class _CategoryListSfw extends State<CategoryListSfw> {
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
