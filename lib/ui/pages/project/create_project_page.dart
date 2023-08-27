import 'dart:io';

import 'package:colab_ezzyfy_solutions/controller/create_project_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/extensions.dart';
import 'package:colab_ezzyfy_solutions/resource/image.dart';
import 'package:colab_ezzyfy_solutions/ui/pages/project/add_user_page.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resource/constant.dart';
import '../../widget/common_toolbar.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  CreateProjectController controller = CreateProjectController.to;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.initController();
  }

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
              CommonToolbar(
                toolbarTitle: 'Create Project',
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
                    child: Obx(
                      () => Padding(
                        padding:  EdgeInsets.all(20.dynamicHeight()),
                        child: Container(
                          width: Get.width,
                          height: 200.dynamicHeight(),
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
                                height: 130.dynamicHeight(),
                                width: 169.dynamicWidth(),
                               )
                              else
                                Image.asset(upload,
                                  height: 130.dynamicHeight(),
                                  width: 169.dynamicWidth(),
                                ),
                              SizedBox(
                                height: 20.dynamicHeight(),
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
                child: inputField2(
                    hintText: 'Enter Project name',
                    controller: controller.projectName,
                    keyboardType: TextInputType.name,
                    validation: (value) {
                      return value?.projectNameValidation();
                    }),
              ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: inputField2(
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
              )
          ),
        );
  }
}
