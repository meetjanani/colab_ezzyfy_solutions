import 'package:get/get.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/project_create_model.dart';

class HomeDashboardController extends GetxController {
  static HomeDashboardController get to => Get.find();
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<ProjectCreateModel> projectList = RxList();

  void fetchProject() async {
    projectList
        .addAll(await projectControllerSupabase.getProjectsByUserId(14));
  }
}
