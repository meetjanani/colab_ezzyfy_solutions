import 'dart:io';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_request_model.dart';
import '../model/user_model_supabase.dart';
import '../shared/colab_shared_preference.dart';
import '../ui/widget/custom_image_picker.dart';

class ProjectListController extends GetxController {
  static ProjectListController get to => Get.find();
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<CreateProjectResponseModel> projectList = RxList();
  RxBool projectLoader = false.obs;
  UserModelSupabase? userModelSupabase = null;
  RxList<File> selectedPhoto = RxList();
  RxList<File> projectAttachmentRequestModel = RxList();
  RxList<ProjectAttachmentsRequestModel> projectAttachmentsListSupabase =
  RxList();

  ProjectListController() {
    init();
  }

  Future<void> init() async {
    projectLoader.value = true;
    await fetchUserProfile();
    await fetchProject();
    projectLoader.value = false;
  }

  Future<void> fetchUserProfile() async {
    userModelSupabase = await getUserModel();
  }
  Future<void> fetchProject() async {
    var response = await projectControllerSupabase.getProjectsByUserId(userModelSupabase?.id ?? 0);
    response.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
    projectList
      ..clear()
      ..addAll(response);
    projectLoader.value = false;
  }

  void addImage(CreateProjectResponseModel project, BuildContext context) async {
    projectAttachmentsListSupabase.clear();
    selectedPhoto.clear();
    List<File> result = await CustomImagePicker().pickImage(context);
    selectedPhoto.value.addAll(result);
    if (result != null) {
      projectLoader.value = true;
      int imageCount = selectedPhoto.value.length;
      for (int i = 0; i < imageCount; i++) {
        await uploadFileOverFirebase(project);
      }
      projectLoader.value = false;
      // insert into supabase in one go
      projectControllerSupabase.createProjectAttachment(projectAttachmentsListSupabase.value);
      await init();
    } else {
      // User canceled the picker
    }
  }

  Future<void> uploadFileOverFirebase(CreateProjectResponseModel project) async {
    File fileToUpload = File(selectedPhoto.value?.first?.path ?? '');
    var projectAttachmentUrl = await firebaseStorageController.uploadImageByProjectId(
      fileToUpload, project,);
    selectedPhoto.value.removeAt(0);
    projectAttachmentsListSupabase.add(ProjectAttachmentsRequestModel(
        projectId: project.id,
        createdByUser: userModelSupabase?.id ?? project.createdByUser,
        projectAttachmentUrl: projectAttachmentUrl));
  }

  Future<void> addEditedPhotoDirectely(File file, CreateProjectResponseModel project) async{
    showProgress();
    selectedPhoto.clear();
    projectAttachmentsListSupabase.clear();
    selectedPhoto.add(file);
    await uploadFileOverFirebase(project);
    hideProgressBar();
    await projectControllerSupabase.createProjectAttachment(projectAttachmentsListSupabase.value);
    return;
  }
}