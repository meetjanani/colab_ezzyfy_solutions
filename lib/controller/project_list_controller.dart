import 'package:get/get.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';

class ProjectListController extends GetxController {
  static ProjectListController get to => Get.find();
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<CreateProjectResponseModel> projectList = RxList();
  Rx<String> userName = "Ronaldo".obs;

  ProjectListController() {
    fetchProject();
  }
  void fetchProject() async {
    await Future.delayed(Duration(seconds: 2));
    projectList
      ..clear()
      ..addAll(await projectControllerSupabase.getProjectsByUserId(14));
  }

  void addImage(int createdByUser){
    fetchProject();
  }
}