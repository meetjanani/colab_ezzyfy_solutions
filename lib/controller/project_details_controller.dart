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

  void fetchProjectAttachments() async {
    projectAttachmentsList
      ..clear()
      ..addAll(await projectControllerSupabase
          .getProjectAttachments(projectResponseModel.id));
  }

  void getAssignedUserByProject() async {
    projectAssignedUserList
      ..clear()
      ..addAll(await projectControllerSupabase
          .getAssignedUserByProject(projectResponseModel.id));
  }
}
