import 'package:flutter/cupertino.dart';
import 'package:grip/common/image/grip_image.dart';

class ContainerImageWidget extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  const ContainerImageWidget(this.width, this.height, this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: context.buildImage(url),
    );
  }
}
