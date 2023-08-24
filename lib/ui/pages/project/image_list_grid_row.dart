import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/project_attchments_response_model.dart';
import '../../widget/colab_catched_image_widget.dart';

class ImageListGridRow extends StatelessWidget {
  final ProjectAttachmentsResponseModel imageAttachment;
  final VoidCallback onImageClick;

  const ImageListGridRow(
      {super.key, required this.imageAttachment, required this.onImageClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onImageClick,
      child: Center(
        child: ColabCatchedImageWidget(
          imageUrl: imageAttachment.projectAttachmentUrl,
          boxFit: BoxFit.contain,
          width: Get.width,
          height: Get.height,
        ),
      ),
    );
  }
}
