import 'package:colab_ezzyfy_solutions/model/project_site_visits_response_model.dart';
import 'package:colab_ezzyfy_solutions/resource/extensions.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/colab_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/project_details_controller.dart';
import '../../../controller/project_site_visit_controller.dart';
import '../../../model/create_project_response_model.dart';
import '../../../resource/constant.dart';
import '../../widget/all_widget.dart';
import '../../widget/colab_catched_image_widget.dart';
import '../../widget/common_toolbar.dart';
import 'add_user_page.dart';

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
    controller.fetchProjectSiteVisits();
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
                        (title, desc) {
                      controller.addSiteVisit(title, desc);
                    }),
                  );
                });
          },
          backgroundColor: colabColorPrimary,
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
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: ColabLoaderWidget(
                      loading: controller.projectSiteVisitsLoader.value,
                      child: ListView.builder(
                          itemCount:
                              controller.projectSiteVisitsList.value.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var record =
                                controller.projectSiteVisitsList.value[index];
                            return siteVisitListRecord(record);
                          }),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
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
            textMore(record.title, Colors.grey, 16,
                FontWeight.w600, 3),
            SizedBox(
              height: 4,
            ),
            textMore(record.description, Colors.black,
                14, FontWeight.w400, 3),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: textMore(record.createAt, Colors.black,
                      16, FontWeight.w600, 3),
                ),
                textMore('Site visit done by: ', Colors.grey, 10,
                    FontWeight.w400, 3),
                textMore(record.userName, Colors.black, 16,
                    FontWeight.w600, 3),
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
}

class AddProjectSiteVisitPage extends StatefulWidget {
  AddProjectSiteVisitPage(this.project, this.user, this.callback, {super.key});

  final String project;
  final String user;
  final Function(String, String) callback;

  @override
  State<AddProjectSiteVisitPage> createState() =>
      _AddProjectSiteVisitPageState();
}

class _AddProjectSiteVisitPageState extends State<AddProjectSiteVisitPage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      keyboardType: TextInputType.name,
                      validation: (value) {
                        return value?.siteVisitDescriptionValidation();
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  greenButton('Submit', () {
                    if (formKey.currentState?.validate() == true) {
                      widget.callback(titleController.text.toString(),
                          descController.text.toString());
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
