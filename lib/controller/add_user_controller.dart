import 'package:get/get.dart';

import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_response_model.dart';
import '../model/user_model_supabase.dart';


class AddUserController extends GetxController {
  static AddUserController get to => Get.find();
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<ProjectAttachmentsResponseModel> projectAttachmentsList = RxList();
  RxList<UserModelSupabase> allSystemUsers = RxList();
  RxList<UserModelSupabase> projectAssignedUserList = RxList();
  late CreateProjectResponseModel projectResponseModel;

  Future<void> getAssignedUserByProject() async {
    projectAssignedUserList
      ..clear()
      ..addAll(await projectControllerSupabase
          .getAssignedUserByProject(projectResponseModel.id));
  }

  void fetAllSystemUsers() async {
    await getAssignedUserByProject();
    allSystemUsers
      ..clear()
      ..addAll(await projectControllerSupabase
          .fetAllSystemUsers());
  }

  void addOrRemoveUserFromProject(int userId) async {
    await projectControllerSupabase.addOrRemoveUserFromProject(userId, projectResponseModel.id);
    fetAllSystemUsers();
  }
}