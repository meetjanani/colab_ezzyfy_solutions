import 'package:cached_network_image/cached_network_image.dart';
import 'package:colab_ezzyfy_solutions/model/create_project_response_model.dart';
import 'package:colab_ezzyfy_solutions/resource/constant.dart';
import 'package:colab_ezzyfy_solutions/route/route.dart';
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
                Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height: Get.width/12,width: Get.width/12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Get.width/12),
                        ),
                        child: Center(
                          child: Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width/7,),
                    text('Project Details', Colors.white, 25, FontWeight.w500),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text('Orchard Bungalows', Colors.black, 18, FontWeight.w700),
                SizedBox(
                  height: 10,
                ),
                Row(

                  children: [
                    Icon(
                      Icons.location_on,
                      color: textVioletColor,
                    ),
                    SizedBox(width: 10,),
                    text(
                        'M-191 Westheimer Rd.',
                        Colors.grey.shade700,
                        12,
                        FontWeight.w600),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(

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
                ),
                SizedBox(height: 20,),
                text('Description', Colors.black, 14, FontWeight.w700),
                SizedBox(height: 10,),
                text('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled Read More. . .', Colors.grey.shade400, 12, FontWeight.w700),
                SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    text('Assign User', Colors.black, 18, FontWeight.w600),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        Get.toNamed(AppRoute.addUser);
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
                SizedBox(height: 20,),
                Container(
                  height: Get.width / 6,
                  child: ListView.builder(
                      itemCount: 8,
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
              ],
            ),
          ),

          Expanded(
            child:  Obx( () =>
               Padding(
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
