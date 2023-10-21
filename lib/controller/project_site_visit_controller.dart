import 'dart:ffi';
import 'dart:io';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_request_model.dart';
import '../model/project_attchments_response_model.dart';
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
  final List<File> localAttachment = [];
  RxList<ProjectAttachmentsRequestModel> projectAttachmentsListSupabase =
  RxList();
  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  RxList<ProjectAttachmentsResponseModel> projectAttachmentsList = RxList();
  RxList<TimeLineAttachmentListModel> timeLineProjectAttachmentsList = RxList();

  Future<void> fetchUserProfile() async {
    userModelSupabase = await getUserModel();
  }

  Future<List<ProjectSiteVisitsResponseModel>> getProjectSiteVisits() async {
    projectSiteVisitsLoader.value = true;
    final response = await Supabase.instance.client
        .from(DatabaseSchema.projectSiteVisitsTable)
        .select(
            '*, users:createdByUser ( name, profilePictureUrl ), projects:projectId ( name )')
        .eq(DatabaseSchema.projectAttachmentsProjectId, projectResponseModel.id)
        .order(DatabaseSchema.projectAttachmentsCreateAt, ascending: false);
    var projectList = ProjectSiteVisitsResponseModel.fromJsonList(response);
    projectSiteVisitsList.value
      ..clear()
      ..addAll(projectList);
    projectSiteVisitsLoader.value = false;
    return projectList;
  }

  Future<void> updateModifiedTimeProjectById(int projectId) async {
    await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .update(
        {DatabaseSchema.projectupdatedAt: DateTime.now().toString()})
        .eq(DatabaseSchema.projectId, projectId)
        .select();
  }

  Future<void> uploadFileOverFirebase() async {
    File fileToUpload = File(localAttachment?.first?.path ?? '');
    var projectAttachmentUrl = await firebaseStorageController.uploadImageByProjectId(
      fileToUpload, projectResponseModel,);
    localAttachment.removeAt(0);
    projectAttachmentsListSupabase.add(ProjectAttachmentsRequestModel(
        projectId: projectResponseModel.id,
        createdByUser: userModelSupabase?.id ?? projectResponseModel.createdByUser,
        projectAttachmentUrl: projectAttachmentUrl));
    if(localAttachment.isNotEmpty) {
      await uploadFileOverFirebase();
    }
  }

  Future<List<String>> createProjectAttachment(
      List<ProjectAttachmentsRequestModel> projectAttachment) async {
    List<String> projectAttachmentId = [];
    showProgress();
    var response = await Supabase.instance.client
        .from(DatabaseSchema.projectAttachmentsTable)
        .insert(ProjectAttachmentsRequestModel.toJsonListProject(projectAttachment)).select();
    // (response as List<dynamic>).map((e) => projectAttachmentId.add(int.tryParse(e['id'].toString()) as Int));
    (response as List<dynamic>).forEach((value){
      projectAttachmentId.add(value['id'].toString());
    });
    await updateModifiedTimeProjectById(projectAttachment.first.projectId);
    hideProgressBar();
    Get.showSuccessSnackbar('Image uploaded successfully.');
    return projectAttachmentId;
  }

  Future<String> uploadAttachment() async {
    String userId = "";
    projectAttachmentsListSupabase.value.clear();
    if(localAttachment.isNotEmpty) {
      await uploadFileOverFirebase();
      var listOfAttachmentId = await createProjectAttachment(projectAttachmentsListSupabase.value);
      userId = listOfAttachmentId.join(',');
    }
    return userId;
  }

  Future<void> addSiteVisit(String title, String desc, String visitDate) async {
    var siteVisitAttachmentId = await uploadAttachment();
    List<ProjectSiteVisitsRequestModel> projectSiteVisit = [];
    projectSiteVisitsLoader.value = true;
    projectSiteVisit.add(ProjectSiteVisitsRequestModel(
        projectId: projectResponseModel.id,
        createdByUser: userModelSupabase?.id ?? 0,
        description: desc,
        title: title,
    attachmentsForSiteVisit: siteVisitAttachmentId,
    visitDate: visitDate));
    await Supabase.instance.client
        .from(DatabaseSchema.projectSiteVisitsTable)
        .insert(
            ProjectSiteVisitsRequestModel.toJsonListProject(projectSiteVisit));
    await projectControllerSupabase.updateModifiedTimeProjectById(projectResponseModel.id);
    Get.showSuccessSnackbar('Site visit are updated successfully.');
    await getProjectSiteVisits();
  }

  Future<void> getAttachmentFromSiteVisit(String attachmentIds) async {
    projectAttachmentsList.value
    ..clear()
    ..addAll(await projectControllerSupabase.getAssignedProjectAttachmentBySiteId(attachmentIds));

    timeLineProjectAttachmentsList.value.clear();
    projectAttachmentsList.value.reversed
        .map((record) => record.createAt)
        .toSet()
        .toList()
        .forEach((e) {
      timeLineProjectAttachmentsList.value.add(TimeLineAttachmentListModel(
          e,
          projectAttachmentsList.value
              .where((element) => element.createAt == e)
              .toList()
              .reversed
              .toList()));
      print(e);
    });
  }
}
