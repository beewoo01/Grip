import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';

class Line extends StatelessWidget {
  const Line({
    Key? key,
    this.color,
    this.margin,
    this.height = 1.0,
  }) : super(key: key);

  final Color? color;
  final EdgeInsets? margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      color: color ?? AppColors.black,
      height: height,
    );
  }
}
