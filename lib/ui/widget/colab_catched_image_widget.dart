import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../resource/image.dart';

class ColabCatchedImageWidget extends StatefulWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  const ColabCatchedImageWidget({
    super.key,
    this.imageUrl,
    this.height = 100,
    this.width = 100,
    this.boxFit = BoxFit.fill,
  });

  @override
  State<ColabCatchedImageWidget> createState() => _ColabCatchedImageWidgetState();
}

class _ColabCatchedImageWidgetState extends State<ColabCatchedImageWidget> {
  get boxfit => null;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: widget.width,
      height: widget.height,
      fit: boxfit,
      imageUrl: widget.imageUrl ?? projectDefaultImageUrl,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
