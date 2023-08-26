import 'package:colab_ezzyfy_solutions/route/app_module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/project_details_controller.dart';
import '../../../model/project_attchments_response_model.dart';
import '../../../resource/image.dart';
import '../../../route/route.dart';
import '../../widget/all_widget.dart';
import '../../widget/colab_catched_image_widget.dart';
import '../../widget/common_toolbar.dart';
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
            CommonToolbar(
              toolbarTitle: 'Project Attachments',
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
