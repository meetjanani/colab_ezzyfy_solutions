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
  List<TimeLineAttachmentListModel> timeLineProjectAttachmentsList = [];

  @override
  void initState() {
    super.initState();
    projectAttachmentsList =
        Get.arguments as List<ProjectAttachmentsResponseModel>;
    projectAttachmentsList.reversed.map((record) => record.createAt).toSet().toList().forEach((e){
      timeLineProjectAttachmentsList.add(TimeLineAttachmentListModel(e, projectAttachmentsList.where((element) => element.createAt == e).toList().reversed.toList()));
      print(e);
    });
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
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonToolbar(
              toolbarTitle: 'Project Attachments',
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4),
                child: ListView.builder(
                    itemCount: timeLineProjectAttachmentsList.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ImageListGridRow(
                        timeLineAttachment: timeLineProjectAttachmentsList[index],
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
