import 'package:colab_ezzyfy_solutions/controller/home_dashboard_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/resource/extensions.dart';
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
import '../../widget/common_toolbar.dart';
import 'feed_row_item.dart';
import 'starred_people_row.dart';

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
    controller.init(showLoader: true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(
            () => Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(height: 44,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(bg), fit: BoxFit.fill),
                              color: Colors.blue)),
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
                                    loading: controller.projectsLoader.value,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: ColabCatchedImageWidget(
                                        imageUrl: controller.userModelSupabase
                                                ?.profilePictureUrl ??
                                            '',
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    controller.changeProfilePicture();
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                text('Hello,', Colors.white, 14,
                                    FontWeight.normal),
                                SizedBox(
                                  width: 5,
                                ),
                                text(controller.userName.value.toString(),
                                    Colors.white, 14, FontWeight.bold),
                                Expanded(
                                  child: Container(),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    controller.firebaseAuthController
                                        .signOutUser(navigateUser: true);
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
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
                            SizedBox(
                              height: 6,
                            ),
                            text('Create\nProject', Colors.black, 12,
                                FontWeight.w500)
                          ],
                        ),
                        onTap: () {
                          if (controller.userModelSupabase?.isAdmin == true) {
                            Get.toNamed(AppRoute.createProject);
                          } else {
                            Get.showErrorSnackbar(
                                "Only Admin user can access this feature");
                          }
                        },
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
                          SizedBox(
                            height: 6,
                          ),
                          text('Create', Colors.black, 12, FontWeight.w500),
                          text('Team', Colors.black, 12, FontWeight.w500)
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
                          SizedBox(
                            height: 6,
                          ),
                          text('Upload', Colors.black, 12, FontWeight.w500),
                          text('Documents', Colors.black, 12, FontWeight.w500)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
                          SizedBox(
                            height: 6,
                          ),
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
                            child: text(
                                'Projects', Colors.black, 18, FontWeight.w600),
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

                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: Get.height * 0.15,
                    ),
                    child: Obx(
                      () => controller.projectsLoader.value == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: controller.projectList.value.isEmpty
                                  ? Container(
                                      height: Get.height * 0.15,
                                      child: Center(
                                          child: text(
                                              'No projects are available for you.',
                                              Colors.black,
                                              18,
                                              FontWeight.w600)),
                                    )
                                  : ListView.builder(
                                      itemCount: controller.projectList.value
                                          .take(3)
                                          .length,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return ProjectRowItem(
                                          projectCreateModel: controller
                                              .projectList.value[index],
                                          onAddImageClick: () {
                                            /*controller.imagesketer(controller.projectList.value[index], context);*/
                                            controller.addImage(
                                                controller
                                                    .projectList.value[index],
                                                context);
                                          },
                                          onProjectClick: () {
                                            Get.toNamed(AppRoute.projectDetails,
                                                    arguments: controller
                                                        .projectList
                                                        .value[index])
                                                ?.then((value) {
                                              controller.init();
                                            });
                                          },
                                        );
                                      }),
                            ),
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
                  SizedBox(
                    height: 10,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: Get.height * 0.15.dynamicHeight(),
                      maxHeight: (Get.height *
                          ((controller.projectFeedsLoader.value == true)
                              ? 0.15
                              : 0.28)),
                    ),
                    child: Obx(() => controller.projectFeedsLoader.value == true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child:
                                controller.projectAttachmentsList.value.isEmpty
                                    ? Container(
                                        height: Get.height * 0.15,
                                        child: Center(
                                            child: text(
                                                'No Feeds are available for you.',
                                                Colors.black,
                                                18,
                                                FontWeight.w600)),
                                      )
                                    : ListView.builder(
                                        itemCount: controller
                                            .projectAttachmentsList
                                            .value
                                            .length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          var attachment = controller
                                              .projectAttachmentsList
                                              .value[index];
                                          return FeedRowItem(
                                            attachment: attachment,
                                          );
                                        }),
                          )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: text(
                        'Starred People', Colors.black, 16, FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 80,
                    child: Obx(
                      () => controller.projectFeedsLoader.value == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ListView.builder(
                                  itemCount:
                                      controller.starredPeople.value.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var starPeople =
                                        controller.starredPeople.value[index];
                                    return StarredPeopleRow(starredPeople: starPeople);
                                  }),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
