import 'dart:io';
import 'dart:typed_data';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_photo_editor/flutter_photo_editor.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_request_model.dart';
import '../model/project_attchments_response_model.dart';
import '../model/user_model_supabase.dart';
import '../resource/database_schema.dart';
import '../resource/session_string.dart';
import '../shared/colab_shared_preference.dart';
import '../ui/widget/custom_image_picker.dart';

class HomeDashboardController extends GetxController {
  static HomeDashboardController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<CreateProjectResponseModel> projectList = RxList();
  RxList<UserModelSupabase> starredPeople = RxList();
  Rx<String> userName = "Ronaldo".obs;
  RxList<File> selectedPhoto = RxList();
  RxList<File> projectAttachmentRequestModel = RxList();
  RxList<ProjectAttachmentsRequestModel> projectAttachmentsListSupabase =
      RxList();
  RxList<ProjectAttachmentsResponseModel> projectAttachmentsList = RxList();
  RxBool projectsLoader = false.obs;
  RxBool projectFeedsLoader = false.obs;
  RxBool isProfilePictureUpload = false.obs;
  UserModelSupabase? userModelSupabase = null;

  Future<bool> init({bool showLoader = false}) async {
    if (showLoader){
      projectsLoader.value = true;
      projectFeedsLoader.value = true;
      isProfilePictureUpload.value = true;
    }
    await fetchUserProfile();
    await fetchProject();
    await fetchFeed();
    projectsLoader.value = false;
    return true;
  }

  Future<void> fetchUserProfile() async {
    userModelSupabase = await getUserModel();
    userName.value = userModelSupabase?.name ?? '';
    isProfilePictureUpload.value = false;
  }

  Future<void> fetchProject() async {
    var response = await projectControllerSupabase.getProjectsByUserId(userModelSupabase?.id ?? 0);
    response.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
    projectList
      ..clear()
      ..addAll(response);
    projectsLoader.value = false;
    fetchProjectUsers();
  }

  Future<void> fetchProjectUsers() async {
    var response = await projectControllerSupabase.getAssignedProjectUsers(projectList.value);
    starredPeople
      ..clear()
      ..addAll(response);
    projectsLoader.value = false;
  }

  Future<void> fetchFeed() async {
    var response = await projectControllerSupabase.getRecentOwnProjectAttachments(userModelSupabase?.id ?? 0);
    projectAttachmentsList
      ..clear()
      ..addAll(response);
    projectFeedsLoader.value = false;
  }

  void addImage(CreateProjectResponseModel project, BuildContext context) async {
    projectAttachmentsListSupabase.clear();
    selectedPhoto.clear();
    List<File> result = await CustomImagePicker().pickImage(context);
    selectedPhoto.value.addAll(result);
    if (selectedPhoto.value.isNotEmpty) {
      showProgress();
      int imageCount = selectedPhoto.value.length;
      for (int i = 0; i < imageCount; i++) {
        await uploadFileOverFirebase(project);
      }
      hideProgressBar();
      // insert into supabase in one go
      await projectControllerSupabase.createProjectAttachment(projectAttachmentsListSupabase.value);
      init();
    } else {
      hideProgressBar();
    }
  }

  void changeProfilePicture(BuildContext context) async {
    List<File> result = await CustomImagePicker().pickImage(context);
    result.forEach((fileTemp) async {
      selectedPhoto.add(fileTemp);
      projectsLoader.value = true;
      await uploadUserProfileOverFirebase();
    });
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

  Future<void> uploadUserProfileOverFirebase() async {
    File fileToUpload = File(selectedPhoto.value?.first?.path ?? '');
    userModelSupabase!.profilePictureUrl = await firebaseStorageController.uploadUserProfileImageByUserId(
      fileToUpload, userModelSupabase!,);

    setColabKey(userProfilePictureSessionStorage, userModelSupabase!.profilePictureUrl);

    await Supabase.instance.client
        .from(DatabaseSchema.usersTable)
        .update(
        {DatabaseSchema.userProfilePictureUrl: userModelSupabase!.profilePictureUrl})
        .eq(DatabaseSchema.usersId, userModelSupabase!.id)
        .select();
    // stre into local shared preference
    await firebaseAuthController.getUserById(userModelSupabase!.id);
    selectedPhoto.value.removeAt(0);
    await init();
    projectsLoader.value = false;
  }
}
