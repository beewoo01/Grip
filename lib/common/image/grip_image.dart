import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grip/common/widget/w_circulator_progress.dart';

import '../url/grip_url.dart';

extension ContextExtention on BuildContext {
  static const double appbarTitleSize = 15;

  CachedNetworkImage buildImage(String url,
      {PlaceholderWidgetBuilder? placeholder,
      LoadingErrorWidgetBuilder? errorWidget,
      double width = double.infinity,
      double height = double.infinity,
      fit = BoxFit.cover,
      isShowPlaceHolder = true}) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: "${GripUrl.imageUrl}$url",
      placeholder:
          placeholder ?? (context, url) => isShowPlaceHolder ?
          const CircularProgressWidget() : Container(),
      errorWidget: errorWidget ??
          (context, url, error) {
            print("error URL IS $url");
            return const Icon(Icons.error);
          },
      fit: fit,
    );
  }
}
