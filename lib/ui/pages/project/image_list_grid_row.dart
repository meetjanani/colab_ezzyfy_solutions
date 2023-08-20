import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/project_attchments_response_model.dart';
import '../../widget/colab_catched_image_widget.dart';

class ImageListGridRow extends StatelessWidget {
  final ProjectAttachmentsResponseModel imageAttachment;
  final VoidCallback onImageClick;

  const ImageListGridRow({super.key, required this.imageAttachment,
  required this.onImageClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onImageClick,
      child: Card(
        elevation: 2,
        color: Colors.white.withOpacity(0.1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: ColabCatchedImageWidget(
                imageUrl: imageAttachment.projectAttachmentUrl,
                boxFit: BoxFit.fill,
                width: Get.width * 0.40,
                height: Get.width * 0.40,
              ),
            )),
      ),
    );
  }
}
