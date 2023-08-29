import 'dart:ffi';
import 'dart:io';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_request_model.dart';
import '../model/project_attchments_response_model.dart';
import '../model/user_model_supabase.dart';
import '../resource/Image_picker_widget.dart';
import '../resource/database_schema.dart';
import '../shared/colab_shared_preference.dart';
import '../shared/get_storage_repository.dart';

class ProjectDetailsController extends GetxController {
  static ProjectDetailsController get to => Get.find();

  ProjectDetailsController(this.getStorageRepository);

  final GetStorageRepository getStorageRepository;
  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<ProjectAttachmentsResponseModel> projectAttachmentsList = RxList();
  RxList<UserModelSupabase> projectAssignedUserList = RxList();
  late CreateProjectResponseModel projectResponseModel;
  RxBool projectAttachmentsLoader = false.obs;
  RxBool projectAssignedUserLoader = false.obs;
  RxList<File> selectedPhoto = RxList();
  RxList<ProjectAttachmentsRequestModel> projectAttachmentsListSupabase =
  RxList();
  UserModelSupabase? userModelSupabase = null;

  Future<void> init() async {
    await fetchUserProfile();
    projectAttachmentsLoader.value = true;
    projectAssignedUserLoader.value = true;
    await fetchProjectAttachments();
    await getAssignedUserByProject();
  }

  Future<void> fetchUserProfile() async {
    userModelSupabase = await getUserModel();
  }

  String? getImageFromIndex(int index) {
    try {
      return projectAttachmentsList.value[index]?.projectAttachmentUrl;
    } catch (e) {
      return null;
    }
  }

  Future<void> fetchProjectAttachments() async {
    projectAttachmentsList.value
      ..clear()
      ..addAll(await projectControllerSupabase
          .getProjectAttachments(projectResponseModel.id));
    projectAttachmentsLoader.value = false;
  }

  Future<void> getAssignedUserByProject() async {
    projectAssignedUserList.value
      ..clear()
      ..addAll(await projectControllerSupabase
          .getAssignedUserByProject(projectResponseModel.id));
    projectAssignedUserLoader.value = false;
  }

  Future<void> uploadProjectAttachment(BuildContext context) async {
    showProgress();
    projectResponseModel;
    projectAttachmentsLoader.value = true;
    projectAttachmentsListSupabase.clear();
    selectedPhoto.clear();
    List<File> result = await ImagePickerWidget().pickImageFromGallery(context);
    selectedPhoto.value.addAll(result);
    if(selectedPhoto.value.isNotEmpty) {
      int imageCount = selectedPhoto.value.length;
      for (int i = 0; i < imageCount; i++) {
        await uploadFileOverFirebase();
      }
      hideProgressBar();
      // insert into supabase in one go
      await projectControllerSupabase.createProjectAttachment(projectAttachmentsListSupabase.value);
      await init();
      projectAttachmentsLoader.value = false;
    }
  }

  Future<void> uploadFileOverFirebase() async {
    File fileToUpload = File(selectedPhoto.value?.first?.path ?? '');
    var projectAttachmentUrl = await firebaseStorageController.uploadImageByProjectId(
      fileToUpload, projectResponseModel,);
    selectedPhoto.value.removeAt(0);
    projectAttachmentsListSupabase.add(ProjectAttachmentsRequestModel(
        projectId: projectResponseModel.id,
        createdByUser: userModelSupabase?.id ?? projectResponseModel.createdByUser,
        projectAttachmentUrl: projectAttachmentUrl));
  }

  Future<void> updateProjectThumbnail(BuildContext context) async {
    projectAttachmentsLoader.value = true;
    List<File> result = await ImagePickerWidget().pickImageFromGallery(context,allowMultipleImages: false);
    File fileToUpload = File(result?.first?.path ?? '');
    var projectNameTrim =
    projectResponseModel.name.toString().replaceAll(' ', '').trim();
    var thumbnailImageUrl = await firebaseStorageController
        .uploadFile(fileToUpload, 'thumbnail_projet_${projectNameTrim}.png',
        projectNameTrim);

    var response = await Supabase.instance.client.from(DatabaseSchema.projectTable)
        .update(
        {DatabaseSchema.projectThumbnailImageUrl: thumbnailImageUrl})
        .eq(DatabaseSchema.projectId, projectResponseModel.id)
        .select();
    projectAttachmentsLoader.value = false;
    showSuccessSnackbar('Project thumbnail updated successfully.');
  }
}
