import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../model/create_project_request_model.dart';
import '../../../model/create_project_response_model.dart';
import '../../../resource/constant.dart';
import '../../../resource/image.dart';
import '../../widget/all_widget.dart';
import '../../widget/catched_image_widget.dart';

class ProjectRowItem extends StatelessWidget {
 final CreateProjectResponseModel projectCreateModel;
 final VoidCallback onAddImageClick;
 const ProjectRowItem({super.key, required this.projectCreateModel, required this.onAddImageClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 100, // max height set as 100
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CatchedImageWidget(imageUrl: projectCreateModel.thumbnailImageUrl,)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                          width: Get.width/2.5,
                          child: textMore(
                              projectCreateModel.name,
                              Colors.black,
                              14,
                              FontWeight.w600,3),
                          ),

                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(5),
                                  border: Border.all(
                                      color: textVioletColor),
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  text('Add', textVioletColor,
                                      10, FontWeight.w500),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.camera_alt,
                                    color: textVioletColor,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                            onTap: onAddImageClick,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
