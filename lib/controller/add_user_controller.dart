import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_response_model.dart';
import '../model/user_model_supabase.dart';


class AddUserController extends GetxController {
  static AddUserController get to => Get.find();
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<UserModelSupabase> allSystemUsers = RxList();
  RxList<UserModelSupabase> searchSystemUser = RxList();
  RxList<UserModelSupabase> projectAssignedUserList = RxList();
  late CreateProjectResponseModel projectResponseModel;
  RxBool loader = false.obs;
  bool isAdduserScreen = false;

  Future<void> getAssignedUserByProject() async {
    if(isAdduserScreen) {
      projectAssignedUserList
        ..clear()
        ..addAll(await projectControllerSupabase
            .getAssignedUserByProject(projectResponseModel.id));
    }
    else {
      projectAssignedUserList
        ..clear()
        ..addAll(await projectControllerSupabase
            .getAssignedSiteVisitUserByProject(projectResponseModel.id));
    }
  }

  void fetAllSystemUsers() async {
    loader.value = true;
    await getAssignedUserByProject();
    if(isAdduserScreen){
      allSystemUsers
        ..clear()
        ..addAll(await projectControllerSupabase
            .fetAllSystemUsers());
    } else {
      allSystemUsers
        ..clear()
        ..addAll(await projectControllerSupabase
            .getAssignedUserByProject(projectResponseModel.id));
    }

    searchSystemUser
      ..clear()
      ..addAll(allSystemUsers);
    loader.value = false;
  }


  void addOrRemoveUser(int userId) async {
    if(isAdduserScreen) {
      addOrRemoveUserFromProject(userId);
    }
    else {
      addOrRemoveSiteVisitUserFromProject(userId);
    }
  }

  void addOrRemoveUserFromProject(int userId) async {
    loader.value = true;
    await projectControllerSupabase.addOrRemoveUserFromProject(userId, projectResponseModel.id);
    fetAllSystemUsers();
  }

  void addOrRemoveSiteVisitUserFromProject(int userId) async {
    loader.value = true;
    await projectControllerSupabase.addOrRemoveAssignedSiteVisitUserFromProject(userId, projectResponseModel.id);
    fetAllSystemUsers();
  }
}