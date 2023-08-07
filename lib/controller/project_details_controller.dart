import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_response_model.dart';
import '../shared/get_storage_repository.dart';

class ProjectDetailsController extends GetxController {
  static ProjectDetailsController get to => Get.find();

  ProjectDetailsController(this.getStorageRepository);

  final GetStorageRepository getStorageRepository;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<ProjectAttachmentsResponseModel> projectAttachmentsResponseModel =
      RxList();
  late CreateProjectResponseModel projectResponseModel;

  void fetchProjectAttachments() async {
    await Future.delayed(Duration(seconds: 2));
    projectAttachmentsResponseModel
      ..clear()
      ..addAll(await projectControllerSupabase.getProjectAttachments(projectResponseModel.id));
  }
}
