import 'package:colab_ezzyfy_solutions/route/app_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/project_details_controller.dart';
import '../../../model/project_attchments_response_model.dart';
import '../../../resource/image.dart';
import '../../../route/route.dart';
import '../../widget/all_widget.dart';
import '../../widget/colab_catched_image_widget.dart';
import 'image_list_grid_row.dart';

class ProjectAttachmentListPage extends StatefulWidget {
  const ProjectAttachmentListPage({super.key});

  @override
  State<ProjectAttachmentListPage> createState() =>
      _ProjectAttachmentListPageState();
}

class _ProjectAttachmentListPageState extends State<ProjectAttachmentListPage> {
  ProjectDetailsController controller = ProjectDetailsController.to;
  List<ProjectAttachmentsResponseModel> projectAttachmentsList = [];

  @override
  void initState() {
    super.initState();
    projectAttachmentsList =
        Get.arguments as List<ProjectAttachmentsResponseModel>;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        refreshDashboardUI();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(bg), fit: BoxFit.fill),
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
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          await refreshDashboardUI();
                          Get.back();
                        },
                        child: Container(
                          height: Get.width / 12,
                          width: Get.width / 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Get.width / 12),
                          ),
                          child: Center(
                            child: Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width / 7,
                      ),
                      text('Project Attachments', Colors.white, 25,
                          FontWeight.w500),
                    ],
                  ),
                  SizedBox(
                    height: Get.width / 10,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0),
                    itemCount: projectAttachmentsList.length,
                    itemBuilder: (context, index) {
                      return ImageListGridRow(
                        imageAttachment: projectAttachmentsList[index],
                        onImageClick: () {
                          Get.toNamed(AppRoute.projectFullScreenAttachment,
                              arguments: projectAttachmentsList[index]);
                        },
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  refreshDashboardUI() {
    controller.init();
  }
}
