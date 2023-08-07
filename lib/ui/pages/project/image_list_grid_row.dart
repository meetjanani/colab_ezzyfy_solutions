import 'package:flutter/material.dart';

import '../../../model/project_attchments_response_model.dart';
import '../../widget/catched_image_widget.dart';

class ImageListGridRow extends StatelessWidget {
  final ProjectAttachmentsResponseModel imageAttachment;
  const ImageListGridRow({super.key, required this.imageAttachment});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Divider(height: 2, color: Colors.black,),
            SizedBox(height: 10,),
            CatchedImageWidget(
              imageUrl: imageAttachment.projectAttachmentUrl,
              width: 220,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
