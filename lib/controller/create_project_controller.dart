import 'dart:io';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/resource/image.dart';
import 'package:colab_ezzyfy_solutions/shared/colab_shared_preference.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_request_model.dart';
import '../model/user_model_supabase.dart';
import '../resource/session_string.dart';
import '../shared/get_storage_repository.dart';
import '../ui/widget/custom_image_picker.dart';

class CreateProjectController extends GetxController {
  static CreateProjectController get to => Get.find();
  final GetStorageRepository getStorageRepository;
  Rx<UserModelSupabase?> userModelSupabase = null.obs;

  CreateProjectController(this.getStorageRepository) {
    initController();
  }

  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  ProjectControllerSupabase supabaseSetupController = ProjectControllerSupabase.to;
  RxBool projectLoader = false.obs;

  var formKey = GlobalKey<FormState>();
  TextEditingController projectName = TextEditingController();
  RxList<File> selectedPhoto = RxList();
  TextEditingController address = TextEditingController();
  var thumbnailImageUrl = "https://firebasestorage.googleapis.com/v0/b/colab-sample.appspot.com/o/default_placeholder%2Fdefault_project_image.png?alt=media&token=95134897-5068-4064-b3e2-0c0b565a8ef7";

  void initController() async {
    userModelSupabase.value = await getUserModel();
  }

  bool fieldValidation() {
    return formKey.currentState?.validate() == true;
  }

  void createProject() async {
    projectLoader.value = true;
    if (!fieldValidation()) {
      projectLoader.value = false;
      return;
    }
    showProgress();
    var sharedPreference = await SharedPreferences.getInstance();
    var userId = sharedPreference.getInt(userIdSessionStorage) ?? 0;
    var signInUser = await firebaseAuthController.getUserById(userId);
    supabaseSetupController
        .checkForDuplicateProject(projectName.text)
        .then((isDuplicate) async {
      if (!isDuplicate) {
        if((selectedPhoto.value.length ?? 0) > 0) {
          File fileToUpload = File(selectedPhoto.value?.first?.path ?? '');
          var projectNameTrim =
          projectName.text.toString().replaceAll(' ', '').trim();
          thumbnailImageUrl = await firebaseStorageController
              .uploadFile(fileToUpload, 'thumbnail_projet_${projectNameTrim}.png',
              projectNameTrim);
        }
        var project = CreateProjectRequestModel(
          name: projectName.text.toString(),
          address: address.text.toString(),
          thumbnailImageUrl: thumbnailImageUrl,
          createdByUser: signInUser.id,
          assignedUser: signInUser.id.toString(),
          assignedSiteVisitUser: signInUser.id.toString(),
        );
        supabaseSetupController.createNewProject(project);
        projectLoader.value = false;
      }
      projectLoader.value = false;
    });
  }

  void selectPhoto(BuildContext context) async {
    List<File> result = await CustomImagePicker().pickImage(context);
    result.forEach((fileTemp) async {
      selectedPhoto.clear();
      selectedPhoto.add(fileTemp);
    });
  }
}
