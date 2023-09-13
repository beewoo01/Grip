import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../url/grip_url.dart';

extension ContextExtention on BuildContext {
  CachedNetworkImage buildImage(String url,
      {PlaceholderWidgetBuilder? placeholder,
      LoadingErrorWidgetBuilder? errorWidget,
      fit = BoxFit.fill}) {

    return CachedNetworkImage(
      imageUrl: "${GripUrl.imageUrl}$url",
      placeholder: placeholder ?? (context, url) => const CircularProgressIndicator(),
      errorWidget: errorWidget ?? (context, url, error)  {
        print("error URL IS $url");
        return const Icon(Icons.error);
      },
      fit: fit,
    );
  }
}
