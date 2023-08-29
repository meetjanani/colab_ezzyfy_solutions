import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/common_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/project_list_controller.dart';
import '../../../resource/image.dart';
import '../../widget/all_widget.dart';
import '../home_dashboard/project_row_item.dart';

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
      body:
        // Obx(
        // () =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonToolbar(
              toolbarTitle: 'All Projects',
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => controller.projectLoader.value == true
                  ? Expanded(
                    child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                  )
                  : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,0),
                      child: ListView.builder(
                          itemCount: controller.projectList.value.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,

                          itemBuilder: (context, index) {
                            return ProjectRowItem(
                              projectCreateModel:
                                  controller.projectList.value[index],
                              onAddImageClick: () {
                                controller.addImage(controller
                                    .projectList.value[index], context);
                              },
                                onProjectClick: () {
                                  Get.toNamed(AppRoute.projectDetails,
                                      arguments: controller
                                          .projectList.value[index])?.then((value){
                                            controller.init();
                                  });
                                },
                            );
                          }),
                    ),
                  ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: (){
                  if(controller.userModelSupabase?.isAdmin == true) {
                    Get.toNamed(AppRoute.createProject)?.then((value){
                      controller.init();
                    });
                  } else {
                    Get.showErrorSnackbar("Only Admin user can access this feature");
                  }
                },
                child: Container(
                  height: 52,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: pinkButtonColor
                  ),
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('New Project',
                              style: const TextStyle(fontSize: 22,color: Colors.white,fontFamily: 'futur',fontWeight: FontWeight.bold)),
                          SizedBox(width: 10,),
                          Icon(Icons.add_box_outlined,color: Colors.white,size: 20,)
                        ],
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

          ],
        ),
      // ),
    );
  }
}
