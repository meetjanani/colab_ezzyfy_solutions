import 'dart:io';

import 'package:colab_ezzyfy_solutions/model/project_site_visits_response_model.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/resource/extensions.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/colab_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/project_details_controller.dart';
import '../../../controller/project_site_visit_controller.dart';
import '../../../model/create_project_response_model.dart';
import '../../../resource/constant.dart';
import '../../../resource/image.dart';
import '../../widget/all_widget.dart';
import '../../widget/common_toolbar.dart';
import '../../widget/custom_image_picker.dart';
import 'add_user_page.dart';
import 'image_list_grid_row.dart';

class ProjectSiteVisitListPage extends StatefulWidget {
  const ProjectSiteVisitListPage({super.key});

  @override
  State<ProjectSiteVisitListPage> createState() =>
      _ProjectSiteVisitListPageState();
}

class _ProjectSiteVisitListPageState extends State<ProjectSiteVisitListPage> {
  ProjectSiteVisitController controller = ProjectSiteVisitController.to;
  ProjectDetailsController projectController = ProjectDetailsController.to;

  @override
  void initState() {
    super.initState();
    controller.projectResponseModel =
        Get.arguments as CreateProjectResponseModel;
    controller.fetchUserProfile();
    controller.getProjectSiteVisits().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        projectController.init();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                useRootNavigator: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                )),
                context: Get.context!,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddProjectSiteVisitPage(
                        controller.projectResponseModel.name.toString(),
                        controller.userModelSupabase?.name ?? '',
                        (title, desc, date) {
                      controller.addSiteVisit(title, desc, date).then((value) {
                        setState(() {});
                      });
                    }),
                  );
                });
          },
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
          ),
        ),
        body: Obx(() => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonToolbar(
                  toolbarTitle: 'Project Site Visits',
                ),
                Expanded(
                    child: controller.projectSiteVisitsList.value.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.all(4),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: controller
                                    .projectSiteVisitsList.value.length,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var record = controller
                                      .projectSiteVisitsList.value[index];
                                  return InkWell(
                                    child: siteVisitListRecord(record),
                                    onTap: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          useRootNavigator: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                            top: Radius.circular(40),
                                          )),
                                          context: Get.context!,
                                          builder: (context) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: ViewProjectSiteVisitPage(
                                                  record),
                                            );
                                          }).then((value) {
                                        controller
                                            .timeLineProjectAttachmentsList
                                            .value
                                            .clear();
                                      });
                                    },
                                  );
                                }),
                          )
                        : Center(
                            child: text('No site visits are available for you.',
                                Colors.black, 18, FontWeight.w600))),
              ],
            )),
      ),
    );
  }
}

Widget siteVisitListRecord(ProjectSiteVisitsResponseModel record) {
  return Card(
    elevation: 2,
    child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textMore(record.title, Colors.grey, 16, FontWeight.w600, null),
          SizedBox(
            height: 4,
          ),
          textMore(record.description, Colors.black, 14, FontWeight.w400, null),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: textMore(
                    record.visitDate.getColabDateFormat(), Colors.black, 16, FontWeight.w600, 3),
              ),
              textMore(
                  'Site visit done by: ', Colors.grey, 10, FontWeight.w400, 3),
              textMore(record.userName, Colors.black, 16, FontWeight.w600, 3),
            ],
          ),
          SizedBox(
            height: 4,
          ),
        ],
      ),
    ),
  );
}

class AddProjectSiteVisitPage extends StatefulWidget {
  AddProjectSiteVisitPage(this.project, this.user, this.callback, {super.key});

  final String project;
  final String user;

  final Function(String, String, String) callback;

  @override
  State<AddProjectSiteVisitPage> createState() =>
      _AddProjectSiteVisitPageState();
}

class _AddProjectSiteVisitPageState extends State<AddProjectSiteVisitPage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  ProjectSiteVisitController controller = ProjectSiteVisitController.to;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  text('Add Site Visit', Colors.black, 22, FontWeight.w800),
                  const SizedBox(height: 10),
                  text(
                      'Your site visit will be added under ${widget.project} by ${widget.user}.',
                      hintTextColor,
                      14,
                      FontWeight.w500),
                  SizedBox(
                    height: 20,
                  ),
                  inputField2(
                      hintText: 'Enter Title',
                      controller: titleController,
                      keyboardType: TextInputType.name,
                      validation: (value) {
                        return value?.siteVisitTitleValidation();
                      }),
                  inputField2(
                      hintText: 'Enter Description',
                      controller: descController,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      validation: (value) {
                        return value?.siteVisitDescriptionValidation();
                      }),
                  InkWell(
                    onTap: () async {
                      // show Date picker
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        selectedDate = pickedDate;
                        setState(() {
                          dateController.text =
                              DateFormat('dd-MM-yyyy').format(pickedDate); //set output date to TextField value.
                        });
                      } else {
                        dateController.text = "";
                      }
                    },
                    child: inputField2(
                        hintText: (dateController.text.isNotEmpty) ? dateController.text.toString() : "Select Date Visit",
                        hintColor: (dateController.text.isNotEmpty) ?  Colors.black : null,
                        editable: false,
                        keyboardType: TextInputType.name,),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: Get.width * 0.25,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Container(
                            height: Get.width * .25,
                            width: Get.width * .25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              child: Image.asset(upload,
                                height: Get.width * 0.16,
                                width: Get.width * 0.16,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onTap: () async {
                            List<File> result =
                                await CustomImagePicker().pickImage(context);
                            controller.localAttachment.addAll(result);
                            setState(() {});
                          },
                        ),
                        Expanded(
                          child: Visibility(
                            visible: controller.localAttachment.isNotEmpty,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: controller.localAttachment.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    height: Get.width * .25,
                                    width: Get.width * .25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      child: Stack(
                                        children: [
                                          Image.file(controller
                                              .localAttachment[index]),
                                          Positioned(
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    controller.localAttachment
                                                        .removeAt(index);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 22,
                                                  color: Colors.red,
                                                )),
                                            right: 0,
                                            bottom: 0,
                                          )
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  greenButton('Submit', () {
                    if (formKey.currentState?.validate() == true) {
                      widget.callback(titleController.text.toString(),
                          descController.text.toString(), DateFormat('yyyy-MM-dd').format(selectedDate).toString());
                      Get.back();
                    }
                  }),
                  SizedBox(height: Get.width * 0.05),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ViewProjectSiteVisitPage extends StatefulWidget {
  final ProjectSiteVisitsResponseModel record;

  ViewProjectSiteVisitPage(this.record, {super.key});

  @override
  State<ViewProjectSiteVisitPage> createState() =>
      _ViewProjectSiteVisitPageState();
}

class _ViewProjectSiteVisitPageState extends State<ViewProjectSiteVisitPage> {
  ProjectSiteVisitController controller = ProjectSiteVisitController.to;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller
          .getAttachmentFromSiteVisit(widget.record.attachmentsForSiteVisit)
          .then((value) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      height: Get.height * 0.88,
      child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(20.0),
                child: siteVisitListRecord(widget.record),
              ),
              Expanded(
                child: Container(
                  height: Get.height * 0.5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: controller
                              .timeLineProjectAttachmentsList.value.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ImageListGridRow(
                              timeLineAttachment: controller
                                  .timeLineProjectAttachmentsList.value[index],
                            );
                          }),
                    ),
                  ),
                ),
              )
            ],
          ),
    ));
  }
}

// Improve project detail screen UI Design: Pending
