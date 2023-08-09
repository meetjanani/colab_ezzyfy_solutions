import 'dart:io';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
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

class CreateProjectController extends GetxController {
  static CreateProjectController get to => Get.find();
  final GetStorageRepository getStorageRepository;

  CreateProjectController(this.getStorageRepository) {
    initController();
  }

  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  ProjectControllerSupabase supabaseSetupController = ProjectControllerSupabase.to;
  Rx<String> userName = "Ronaldo".obs;
  RxBool projectLoader = false.obs;

  var formKey = GlobalKey<FormState>();
  TextEditingController projectName = TextEditingController();
  RxList<File> selectedPhoto = RxList();
  TextEditingController address = TextEditingController();
  var thumbnailImageUrl = "https://firebasestorage.googleapis.com/v0/b/colab-sample.appspot.com/o/default_placeholder%2Fdefault_project_image.png?alt=media&token=95134897-5068-4064-b3e2-0c0b565a8ef7";

  void initController() async {
    SharedPreferences.getInstance().then((value)async {
      userName.value = value.getString('userName') ?? userName.value;
    });
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
    var sharedPreference = await SharedPreferences.getInstance();
    var userId = sharedPreference.getInt(userIdSessionStorage) ?? 0;
    var signInUser = await firebaseAuthController.getUserById(userId);
    print(" $userName, $signInUser");
    supabaseSetupController
        .checkForDuplicateProject(projectName.text)
        .then((isDuplicate) async {
      if (!isDuplicate) {
        if(selectedPhoto.value?.firstOrNull != null) {
          File fileToUpload = File(selectedPhoto.value?.firstOrNull?.path ?? '');
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
        );
        supabaseSetupController.createNewProject(project);
        projectLoader.value = false;
        Get.back();
      }
      projectLoader.value = false;
    });
  }

  void selectPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
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
        } else {
          Get.showErrorSnackbar('File size is more then 30 MB');
        }
      }
    } else {
      // User canceled the picker
    }
  }
}
