import 'dart:io';

import 'package:colab_ezzyfy_solutions/controller/create_project_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/extensions.dart';
import 'package:colab_ezzyfy_solutions/resource/image.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource/constant.dart';

class CreateProjectPage extends GetView<CreateProjectController> {
  const CreateProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
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
                    text('Colab', Colors.white, 25, FontWeight.w500),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: text('Create Project', Colors.black, 22,
                    FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: controller.selectPhoto,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: DottedBorder(
                    color: uploadImageDottedBorderColor,
                    borderType: BorderType.RRect,
                    dashPattern: [12, 5],
                    strokeWidth: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Obx(
                        () => Container(
                          width: Get.width,
                          height: 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              if (controller
                                      .selectedPhoto.isNotEmpty
                                  )
                                Image.file(File(controller.selectedPhoto.value.first.path ??
                                    ""),
                                height: 200,
                                width: Get.width,
                                fit: BoxFit.cover,)
                              else
                                Image.asset(upload),
                              SizedBox(
                                height: 16,
                              ),
                              text('Upload Media', Colors.blue, 14,
                                  FontWeight.w500)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: inputField(
                    hintText: 'Enter Project name',
                    controller: controller.projectName,
                    keyboardType: TextInputType.name,
                    validation: (value) {
                      return value?.projectNameValidation();
                    }),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: inputField(
                    hintText: 'Enter Address',
                    controller: controller.address,
                    keyboardType: TextInputType.name,
                    validation: (value) {
                      return value?.projectNameValidation();
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              controller.projectLoader.value == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: greenButton('Create Project', () {
                        // showDialog(
                        //   context: Get.context!,
                        //
                        //   builder: (BuildContext context) {
                        //
                        //     return Dialog(
                        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        //       child: Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           Image.asset(alert1),
                        //           text('Congratulation', Colors.black, 28, FontWeight.w600),
                        //           SizedBox(height: 5,),
                        //           text('Project Created', Colors.grey, 16, FontWeight.w400),
                        //           text('Successfully', Colors.grey, 16, FontWeight.w400),
                        //           SizedBox(height: 10,),
                        //           blueButton('Done', (){Get.back();},52,Get.width/2),
                        //           SizedBox(height: 10,),
                        //         ],
                        //       ),
                        //     );
                        //
                        //   },
                        // );
                        controller.createProject();

                      }),
                    ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
