import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
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
                        onTap: () {
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
                        width: Get.width / 4,
                      ),
                      text('Recent Projects', Colors.white, 18, FontWeight.w500),
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
                                          .projectList.value[index]);
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
                    Get.toNamed(AppRoute.createProject);
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
