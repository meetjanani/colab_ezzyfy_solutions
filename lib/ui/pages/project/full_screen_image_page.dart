import 'package:colab_ezzyfy_solutions/resource/extensions.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/colab_catched_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/project_attchments_response_model.dart';

class FullScreenImagePage extends StatelessWidget {
  const FullScreenImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          height: Get.width.dynamicWidth(),
          width: Get.width.dynamicWidth(),
          child: Center(
            child: ColabCatchedImageWidget(
              imageUrl: (Get.arguments as ProjectAttachmentsResponseModel)
                  .projectAttachmentUrl,
              height: Get.width.dynamicWidth(),
              width: Get.width.dynamicWidth(),
              boxFit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
