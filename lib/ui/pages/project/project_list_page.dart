import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/project_list_controller.dart';
import '../../../resource/image.dart';
import '../../widget/all_widget.dart';
import '../Auth/project_row_item.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  ProjectListController controller = ProjectListController();
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
                image: DecorationImage(
                    image: AssetImage(bg), fit: BoxFit.fill),
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
                text('All Projects', Colors.white, 25, FontWeight.w500),
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
                    text(controller.userName.value.toString(), Colors.white, 14, FontWeight.bold),
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
          Obx(
                () => Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Expanded(
                child: ListView.builder(
                    itemCount: controller.projectList.value.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ProjectRowItem(projectCreateModel: controller.projectList.value[index],
                        onAddImageClick: (){
                          controller.addImage(controller.projectList.value[index].createdByUser);
                        },);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
