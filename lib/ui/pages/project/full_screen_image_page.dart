import 'package:colab_ezzyfy_solutions/ui/widget/colab_catched_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/project_attchments_response_model.dart';

class FullScreenImagePage extends StatelessWidget {
  const FullScreenImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColabCatchedImageWidget(
      imageUrl: (Get.arguments as ProjectAttachmentsResponseModel)
          .projectAttachmentUrl,
      height: Get.height,
      width: Get.height,
      boxFit: BoxFit.fill,
    );
  }
}
