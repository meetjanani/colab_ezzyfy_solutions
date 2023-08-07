import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../resource/image.dart';

class CatchedImageWidget extends StatefulWidget {
  final String? imageUrl;
  final double? width;
  final double? height;

  const CatchedImageWidget({
    super.key,
    this.imageUrl,
    this.height = 100,
    this.width = 100,
  });

  @override
  State<CatchedImageWidget> createState() => _CatchedImageWidgetState();
}

class _CatchedImageWidgetState extends State<CatchedImageWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: widget.width,
      height: widget.height,
      fit: BoxFit.fill,
      imageUrl: widget.imageUrl ?? projectDefaultImageUrl,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
