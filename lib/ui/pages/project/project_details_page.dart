import 'package:colab_ezzyfy_solutions/controller/home_dashboard_controller.dart';
import 'package:colab_ezzyfy_solutions/model/create_project_response_model.dart';
import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/project/image_list_grid_row.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/colab_catched_image_widget.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/colab_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  HomeDashboardController homeController = HomeDashboardController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.projectResponseModel =
        Get.arguments as CreateProjectResponseModel;
  }

  @override
  Widget build(BuildContext context) {
    controller.init();
    return WillPopScope(
      onWillPop: () async{
        return refreshDashboardUI();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => Column(
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
                                borderRadius:
                                    BorderRadius.circular(Get.width / 12),
                              ),
                              child: Center(
                                child: Icon(Icons.arrow_back_ios_new),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 7,
                          ),
                          text('Project Details', Colors.white, 25,
                              FontWeight.w500),
                        ],
                      ),
                      SizedBox(
                        height: Get.width/10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ColabLoaderWidget(
                          loading: controller.projectAttachmentsLoader.value,
                          child: Column(
                            children: [
                              Container(
                                height: (controller.getImageFromIndex(1) !=
                                    null) ? Get.width / 1.7 : 0,


                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: (controller.getImageFromIndex(0) !=
                                              null)
                                          ? ColabCatchedImageWidget(
                                              imageUrl:
                                                  controller.getImageFromIndex(0),
                                              boxFit: BoxFit.cover,
                                              width: Get.width,
                                              height: Get.width * 0.50,
                                            )
                                          : SizedBox(),
                                    ),
                                    Visibility(
                                      visible: false,
                                      child: Positioned(
                                        child: Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SvgPicture.asset(
                                              heart,
                                              color: Colors.red,
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                        ),
                                        top: Get.width / 20,
                                        right: Get.width / 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: (controller.getImageFromIndex(1) !=
                                        null) ? Get.width * .25 : 0,
                                    width: Get.width * .25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      child: (controller.getImageFromIndex(1) !=
                                              null)
                                          ? ColabCatchedImageWidget(
                                              imageUrl:
                                                  controller.getImageFromIndex(1),
                                              boxFit: BoxFit.cover,
                                              width: Get.width,
                                              height: Get.width * 0.50,
                                            )
                                          : SizedBox(),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Container(
                                    height: (controller.getImageFromIndex(1) !=
                                        null) ? Get.width * .25 : 0,
                                    width: Get.width * .25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      child: (controller.getImageFromIndex(2) !=
                                              null)
                                          ? ColabCatchedImageWidget(
                                              imageUrl:
                                                  controller.getImageFromIndex(2),
                                              boxFit: BoxFit.cover,
                                              width: Get.width,
                                              height: Get.width * 0.50,
                                            )
                                          : SizedBox(),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: (controller.getImageFromIndex(1) !=
                                            null) ? Get.width * .25 : 0,
                                        width: Get.width * .25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          child:
                                              (controller.getImageFromIndex(3) !=
                                                      null)
                                                  ? ColabCatchedImageWidget(
                                                      imageUrl: controller
                                                          .getImageFromIndex(3),
                                                      boxFit: BoxFit.cover,
                                                      width: Get.width,
                                                      height: Get.width * 0.50,
                                                    )
                                                  : SizedBox(),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: text( controller.projectAttachmentsList.value.length - 3 < 0 ? '' :
                                                '${controller.projectAttachmentsList.value.length - 3}+',
                                                Colors.white,
                                                24,
                                                FontWeight.w600)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )),
                      SizedBox(
                        height: Get.width * 0.08,
                      ),
                      text(controller.projectResponseModel.name, Colors.black, 18,
                          FontWeight.w700),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: textVioletColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          text(controller.projectResponseModel.address,
                              Colors.grey.shade700, 12, FontWeight.w600),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Hinding Phone number view
                      /*Row(
                    children: [
                      Icon(
                        Icons.phone_in_talk,
                        color: textVioletColor,
                      ),
                      SizedBox(width: 10,),
                      text(
                          '+1 1234567890',
                          Colors.grey.shade700,
                          12,
                          FontWeight.w600),
                    ],
                  ),*/
                      //Project Description view
                      /*SizedBox(
                        height: 20,
                      ),
                      text('Description', Colors.black, 14, FontWeight.w700),
                      SizedBox(
                        height: 10,
                      ),
                      text(
                          'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled Read More. . .',
                          Colors.grey.shade400,
                          12,
                          FontWeight.w700),*/
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          text('Assign User', Colors.black, 18, FontWeight.w600),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoute.addUser, arguments: controller.projectResponseModel);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: textVioletColor),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.add_circle_outline_sharp,
                                      color: textVioletColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    text('Add User', textVioletColor, 14,
                                        FontWeight.w500),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Container(
                        height: 80,
                        child: ColabLoaderWidget(
                          loading: controller.projectAttachmentsLoader.value,
                          child: ListView.builder(
                              itemCount:
                              controller.projectAssignedUserList.value.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40)),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(60),
                                          child: ColabCatchedImageWidget(
                                            imageUrl: controller
                                                .projectAssignedUserList
                                                .value[index]
                                                .profilePictureUrl,
                                            height: 54,
                                            width: 54,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future<bool> refreshDashboardUI() {
    return homeController.init();
  }
}
