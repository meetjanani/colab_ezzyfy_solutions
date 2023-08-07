import 'package:cached_network_image/cached_network_image.dart';
import 'package:colab_ezzyfy_solutions/model/create_project_response_model.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/project/image_list_grid_row.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/catched_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/project_details_controller.dart';
import '../../../resource/image.dart';
import '../../widget/all_widget.dart';

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({super.key});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  ProjectDetailsController controller = ProjectDetailsController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.projectResponseModel =
        Get.arguments as CreateProjectResponseModel;
    controller.fetchProjectAttachments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(bg), fit: BoxFit.fill),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 44,
                ),
                text('Project Details', Colors.white, 25, FontWeight.w500),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(),
                    SizedBox(
                      width: 10,
                    ),
                    text('Hello,', Colors.white, 14, FontWeight.normal),
                    SizedBox(
                      width: 5,
                    ),
                    text('Project Name'.toString(), Colors.white, 14,
                        FontWeight.bold),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.70,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount:
                        controller.projectAttachmentsResponseModel.value.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ImageListGridRow(
                        imageAttachment: controller
                            .projectAttachmentsResponseModel.value[index],
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
