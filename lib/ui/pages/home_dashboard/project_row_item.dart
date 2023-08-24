import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../model/create_project_response_model.dart';
import '../../../resource/constant.dart';
import '../../widget/all_widget.dart';
import '../../widget/colab_catched_image_widget.dart';

class ProjectRowItem extends StatelessWidget {
  final CreateProjectResponseModel projectCreateModel;
  final VoidCallback onAddImageClick;
  final VoidCallback onProjectClick;

  const ProjectRowItem({
    super.key,
    required this.projectCreateModel,
    required this.onAddImageClick,
    required this.onProjectClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onProjectClick,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 100, // max height set as 100
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColabCatchedImageWidget(
                    imageUrl: projectCreateModel.thumbnailImageUrl,
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: textMore(projectCreateModel.name, Colors.black,
                              14, FontWeight.w600, 3),
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: textVioletColor),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.camera_alt,
                                color: textVioletColor,
                                size: 20,
                              ),
                            ),
                          ),
                          onTap: onAddImageClick,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
