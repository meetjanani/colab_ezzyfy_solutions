import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../model/project_attchments_response_model.dart';
import '../../../resource/constant.dart';
import '../../../resource/image.dart';
import '../../widget/all_widget.dart';
import '../../widget/colab_catched_image_widget.dart';

class FeedRowItem extends StatelessWidget {
  final ProjectAttachmentsResponseModel attachment;
  const FeedRowItem({super.key, required this.attachment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ColabCatchedImageWidget(
                  imageUrl:
                  attachment.projectAttachmentUrl,
                  height: Get.width * 0.33,
                  width: Get.width * 0.33,
                  boxFit: BoxFit.contain,
                ),
              ),
             /* Positioned(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(50),
                      color: textVioletColor),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ColabCatchedImageWidget(
                      imageUrl: attachment.profilePictureUrl,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                top: 5,
                right: 5,
              )*/
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text("Project: ", Colors.grey, 14,
                    FontWeight.w400),
                text(attachment?.projectName ?? "", Colors.black, 14,
                    FontWeight.w600),
                text("Uploaded by: ", Colors.grey, 14,
                    FontWeight.w400),
                text(
                    attachment?.userName ?? "",
                    Colors.grey.shade700,
                    12,
                    FontWeight.w600),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ColabCatchedImageWidget(
                    imageUrl: attachment.profilePictureUrl,
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
