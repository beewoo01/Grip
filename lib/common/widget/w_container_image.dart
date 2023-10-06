import 'package:flutter/cupertino.dart';
import 'package:grip/common/image/grip_image.dart';
import 'package:grip/common/widget/w_circulator_progress.dart';

class ContainerImageWidget extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final BoxFit fit;
  const ContainerImageWidget(this.width, this.height, this.url, {super.key, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: context.buildImage(url, fit: fit, placeholder: (context, url) => const CircularProgressWidget()),
    );
  }
}
