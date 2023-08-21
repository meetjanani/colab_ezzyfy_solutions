import 'package:colab_ezzyfy_solutions/controller/home_dashboard_controller.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/home_dashboard/project_row_item.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/colab_catched_image_widget.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/colab_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../resource/constant.dart';
import '../../../resource/image.dart';
import '../../widget/all_widget.dart';

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({super.key});

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  HomeDashboardController controller = HomeDashboardController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(
          () => Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
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
                          text('Colab', Colors.white, 25, FontWeight.w500),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                child: ColabLoaderWidget(
                                  loading: controller.projectLoader.value,
                                  child: CircleAvatar(
                                    child: ColabCatchedImageWidget(imageUrl: controller.userModelSupabase?.profilePictureUrl ?? ''),
                                  ),
                                ),
                                onTap: (){
                                  controller.changeProfilePicture();
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              text('Hello,', Colors.white, 14, FontWeight.normal),
                              SizedBox(
                                width: 5,
                              ),
                              text(controller.userName.value.toString(),
                                  Colors.white, 14, FontWeight.bold),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Column(
                        children: [
                          Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: 50,
                              width: 55,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  plus,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 6,),
                          text('Create\nProject', Colors.black, 12,
                              FontWeight.w500)
                        ],
                      ),
                      onTap: () {
                        Get.toNamed(AppRoute.createProject);
                      },
                    ),
                    Column(
                      children: [
                        Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: 50,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                team,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 6,),
                        text('Create', Colors.black, 12, FontWeight.w500),
                        text('Team', Colors.black, 12, FontWeight.w500)
                      ],
                    ),
                    Column(
                      children: [
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: 50,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                up,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 6,),
                        text('Upload', Colors.black, 12, FontWeight.w500),
                        text('Documents', Colors.black, 12, FontWeight.w500)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: 50,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                scan,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 6,),
                        text('Scan', Colors.black, 12, FontWeight.w500),
                        text('Documents', Colors.black, 12, FontWeight.w500)
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      InkWell(
                          child:
                              text('Projects', Colors.black, 18, FontWeight.w600),
                          onTap: () {
                            controller.fetchProject();
                          }),
                      Spacer(),
                      InkWell(
                        child: text(
                            'View all', textVioletColor, 16, FontWeight.w500),
                        onTap: () {
                          Get.toNamed(AppRoute.projectList);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Obx(
                  () => controller.projectLoader.value == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.builder(
                              itemCount: controller.projectList.value.take(3).length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ProjectRowItem(
                                  projectCreateModel:
                                      controller.projectList.value[index],
                                  onAddImageClick: () {
                                    controller.addImage(
                                        controller.projectList.value[index], context);
                                  },
                                  onProjectClick: () {
                                    Get.toNamed(AppRoute.projectDetails,
                                        arguments:
                                            controller.projectList.value[index]);
                                  },
                                );
                              }),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      text('Feed', Colors.black, 18, FontWeight.w600),
                      Spacer(),
                      InkWell(
                        child: text(
                            'View all', textVioletColor, 16, FontWeight.w500),
                        onTap: () {
                          controller.firebaseAuthController.signOutUser();
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Get.width / 1.4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                        itemCount: controller.projectAttachmentsList.value.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var attachment = controller.projectAttachmentsList.value[index];
                          return Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: ColabCatchedImageWidget(
                                            imageUrl:
                                                attachment.projectAttachmentUrl,
                                            height: Get.width / 3,
                                            width: Get.width / 3,
                                            boxFit: BoxFit.cover,
                                          )),
                                      Positioned(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: textVioletColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SvgPicture.asset(
                                              heart,
                                              color: Colors.white,
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                        ),
                                        top: 5,
                                        right: 5,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          text(attachment.projectName, Colors.black, 14,
                                              FontWeight.w600),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: textVioletColor,
                                          ),
                                          text(
                                              attachment.userName,
                                              Colors.grey.shade700,
                                              12,
                                              FontWeight.w600),
                                        ],
                                      ),
                                      SizedBox(height: 10,)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child:
                      text('Starred People', Colors.black, 16, FontWeight.w700),
                ),
                Container(
                  height: Get.width / 3.5,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(ex)),
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
          ),
        ),
      ),
    );
  }
}
