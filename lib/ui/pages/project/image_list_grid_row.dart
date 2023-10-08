import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/project_attchments_response_model.dart';
import '../../../resource/image.dart';
import '../../../route/route.dart';
import '../../widget/all_widget.dart';
import '../../widget/colab_catched_image_widget.dart';

class ImageListGridRow extends StatefulWidget {
  final TimeLineAttachmentListModel timeLineAttachment;

  const ImageListGridRow(
      {super.key, required this.timeLineAttachment});

  @override
  State<ImageListGridRow> createState() => _ImageListGridRowState();
}

class _ImageListGridRowState extends State<ImageListGridRow> {
  @override
  Widget build(BuildContext context) {
    return dateWileImage();
  }

  Widget dateWileImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          width: Get.size.width,
          child: text(widget.timeLineAttachment.createAt, Colors.black, 14, FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.all(4),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.timeLineAttachment.imagesForDay.length,
              itemBuilder: (context, index) {
                return imageTile(widget.timeLineAttachment.imagesForDay[index]);
              }),
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  InkWell imageTile(ProjectAttachmentsResponseModel imageAttachment) {
    return InkWell(
      onTap: (){
        Get.toNamed(AppRoute.projectFullScreenAttachment,
            arguments: imageAttachment);
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),),
          child: ColabCatchedImageWidget(
            imageUrl: imageAttachment.projectAttachmentUrl,
            boxFit: BoxFit.contain,
            width: Get.width,
            height: Get.height,
          ),
        ),
      ),
    );
  }
}
