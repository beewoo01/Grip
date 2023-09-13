import 'package:flutter/material.dart';

import '../color/AppColors.dart';

const separator10 = SeparatorContainer(10, 10);

class SeparatorContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;

  const SeparatorContainer(this.width, this.height, {super.key, this.color});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 10,
      width: 10,
      color: color ?? AppColors.white,
    );
  }
}
