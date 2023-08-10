import 'dart:io';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_request_model.dart';
import '../model/user_model_supabase.dart';
import '../resource/database_schema.dart';
import '../resource/session_string.dart';
import '../shared/colab_shared_preference.dart';

class HomeDashboardController extends GetxController {
  static HomeDashboardController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<CreateProjectResponseModel> projectList = RxList();
  Rx<String> userName = "Ronaldo".obs;
  RxList<File> selectedPhoto = RxList();
  RxList<File> projectAttachmentRequestModel = RxList();
  RxList<ProjectAttachmentsRequestModel> projectAttachmentsListSupabase =
      RxList();
  RxBool projectLoader = false.obs;
  RxBool isProfilePictureUpload = false.obs;
  UserModelSupabase? userModelSupabase = null;

  Future<bool> init() async {
    projectLoader.value = true;
    userModelSupabase = await getUserModel();
    userName.value = userModelSupabase?.name ?? '';
    Future.delayed(Duration(seconds: 2));
    fetchProject();
    return true;
  }

  void fetchProject() async {
    projectLoader.value = true;
    await Future.delayed(Duration(seconds: 2));
    projectList
      ..clear()
      ..addAll(await projectControllerSupabase.getProjectsByUserId(userModelSupabase?.id ?? 0));
    projectLoader.value = false;
  }

  void addImage(CreateProjectResponseModel project) async {
    projectAttachmentsListSupabase.clear();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'jpeg',
      ],
    );
    if (result != null) {
      List<File> fileTemp =
          result.paths.map((path) => File(path ?? '')).toList();
      for (int i = 0; i < fileTemp.length; i++) {
        int sizeInBytes = fileTemp[i].lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb < 30) {
          selectedPhoto.clear();
          selectedPhoto.add(fileTemp[i]);
          await uploadFileOverFirebase(project);
        } else {
          Get.showErrorSnackbar('File size is more then 30 MB');
        }
      }
      // insert into supabase in one go
      projectControllerSupabase.createProjectAttachment(projectAttachmentsListSupabase.value);
    } else {
      // User canceled the picker
    }
  }

  void changeProfilePicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'jpeg',
      ],
    );
    if(result != null) {
      List<File> fileTemp =
      result.paths.map((path) => File(path ?? '')).toList();
      for (int i = 0; i < fileTemp.length; i++) {
        int sizeInBytes = fileTemp[i].lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb < 30) {
          selectedPhoto.add(fileTemp[i]);
          projectLoader.value = true;
          await uploadUserProfileOverFirebase();
        } else {
          Get.showErrorSnackbar('File size is more then 30 MB');
        }
      }
    }
  }

  Future<void> uploadFileOverFirebase(CreateProjectResponseModel project) async {
    File fileToUpload = File(selectedPhoto.value?.first?.path ?? '');
    var projectAttachmentUrl = await firebaseStorageController.uploadImageByProjectId(
        fileToUpload, project,);
    projectAttachmentsListSupabase.add(ProjectAttachmentsRequestModel(
        projectId: project.id,
        createdByUser: project.createdByUser,
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
    await firebaseAuthController.getUserById(userModelSupabase!.id);
    init();
    projectLoader.value = false;
  }
}
