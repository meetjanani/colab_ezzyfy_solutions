import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_site_visits_request_model.dart';
import '../model/project_site_visits_response_model.dart';
import '../model/user_model_supabase.dart';
import '../resource/database_schema.dart';
import '../shared/colab_shared_preference.dart';
import '../shared/get_storage_repository.dart';

class ProjectSiteVisitController extends GetxController {
  static ProjectSiteVisitController get to => Get.find();

  ProjectSiteVisitController(this.getStorageRepository);

  final GetStorageRepository getStorageRepository;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<ProjectSiteVisitsResponseModel> projectSiteVisitsList = RxList();
  RxBool projectSiteVisitsLoader = false.obs;
  UserModelSupabase? userModelSupabase = null;
  late CreateProjectResponseModel projectResponseModel;
  var projectName = 0;

  // TODO: SITE VISITS
  Future<void> fetchProjectSiteVisits() async {
    projectSiteVisitsLoader.value = true;
    projectSiteVisitsList.value
      ..clear()
      ..addAll(await getProjectSiteVisits());
    projectSiteVisitsLoader.value = false;
  }

  Future<void> fetchUserProfile() async {
    userModelSupabase = await getUserModel();
  }

  Future<List<ProjectSiteVisitsResponseModel>> getProjectSiteVisits() async {
    final response = await Supabase.instance.client
        .from(DatabaseSchema.projectSiteVisitsTable)
        .select(
            '*, users:createdByUser ( name, profilePictureUrl ), projects:projectId ( name )')
        .eq(DatabaseSchema.projectAttachmentsProjectId, projectResponseModel.id)
        .order(DatabaseSchema.projectAttachmentsCreateAt, ascending: false);
    var projectList = ProjectSiteVisitsResponseModel.fromJsonList(response);
    return projectList;
  }

  Future<void> addSiteVisit(String title, String desc) async {
    List<ProjectSiteVisitsRequestModel> projectSiteVisit = [];
    projectSiteVisitsLoader.value = true;
    projectSiteVisit.add(ProjectSiteVisitsRequestModel(
        projectId: projectResponseModel.id,
        createdByUser: userModelSupabase?.id ?? 0,
        description: desc,
        title: title));
    await Supabase.instance.client
        .from(DatabaseSchema.projectSiteVisitsTable)
        .insert(
            ProjectSiteVisitsRequestModel.toJsonListProject(projectSiteVisit));
    await projectControllerSupabase.updateModifiedTimeProjectById(projectResponseModel.id);
    Get.showSuccessSnackbar('Site visit are updated successfully.');
    await fetchProjectSiteVisits();
  }
}
