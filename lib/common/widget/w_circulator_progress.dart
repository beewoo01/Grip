import 'package:flutter/material.dart';

class CircularProgressWidget extends StatelessWidget {
  final double width;
  final double height;

  const CircularProgressWidget({super.key, this.width = 30, this.height = 30});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: const CircularProgressIndicator(),
    );
  }
}
