import 'dart:ffi';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_response_model.dart';
import '../model/user_model_supabase.dart';
import '../shared/get_storage_repository.dart';

class ProjectDetailsController extends GetxController {
  static ProjectDetailsController get to => Get.find();

  ProjectDetailsController(this.getStorageRepository);

  final GetStorageRepository getStorageRepository;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<ProjectAttachmentsResponseModel> projectAttachmentsList = RxList();
  RxList<UserModelSupabase> projectAssignedUserList = RxList();
  late CreateProjectResponseModel projectResponseModel;
  RxBool projectAttachmentsLoader = false.obs;
  RxBool projectAssignedUserLoader = false.obs;

  void init() {
    projectAttachmentsLoader.value = true;
    projectAssignedUserLoader.value = true;
    Future.delayed(Duration(seconds: 2)).then((value) {
      fetchProjectAttachments();
      getAssignedUserByProject();
      // hideProgressBar();
    });
  }
  String? getImageFromIndex(int index) {
    try {
      return projectAttachmentsList.value[index]?.projectAttachmentUrl;
    } catch (e) {
      return null;
    }
  }

  void fetchProjectAttachments() async {
    projectAttachmentsLoader.value = true;
    projectAttachmentsList
      ..clear()
      ..addAll(await projectControllerSupabase
          .getProjectAttachments(projectResponseModel.id));
    projectAttachmentsLoader.value = false;
  }

  void getAssignedUserByProject() async {
    projectAssignedUserLoader.value = true;
    projectAssignedUserList
      ..clear()
      ..addAll(await projectControllerSupabase
          .getAssignedUserByProject(projectResponseModel.id));
    projectAssignedUserLoader.value = false;
  }
}
