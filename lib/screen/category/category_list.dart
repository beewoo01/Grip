import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State createState() => CategoryState();
}

class CategoryState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 300,
        height: 200,
        child:
            ListView.builder(itemBuilder: (BuildContext context, int position) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(width: 300, height: 200, color: AppColors.black),
          );
        }),
      ),
    );
  }
}
