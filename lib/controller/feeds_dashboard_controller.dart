import 'package:get/get.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/project_attchments_response_model.dart';
import '../model/user_model_supabase.dart';

class FeedsDashboardController extends GetxController {
  static FeedsDashboardController get to => FeedsDashboardController.to;
  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  Rx<String> userName = "Ronaldo".obs;
  RxList<ProjectAttachmentsResponseModel> projectAttachmentsList = RxList();
  RxBool feedsLoader = false.obs;
  UserModelSupabase? userModelSupabase = null;

  Future<void> init() async {
    feedsLoader.value = true;
    await fetchFeedsOfUserAssignedProjects();
    feedsLoader.value = false;
  }

  Future<void> fetchFeedsOfUserAssignedProjects() async {
    projectAttachmentsList
      ..clear()
      ..addAll(
          await projectControllerSupabase.getAssignedProjectWiseAttachments(userModelSupabase?.id ?? 0));
  }
}
