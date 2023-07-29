import 'dart:io';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/supabase_setup_controller.dart';
import '../model/project_create_model.dart';
import '../model/user_model_supabase.dart';
import '../shared/get_storage_repository.dart';

class CreateProjectController extends GetxController {
  static CreateProjectController get to => Get.find();
  final GetStorageRepository getStorageRepository;

  CreateProjectController(this.getStorageRepository);

  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  SupabaseSetupController supabaseSetupController = SupabaseSetupController.to;

  var formKey = GlobalKey<FormState>();
  TextEditingController projectName = TextEditingController();
  RxList<File> selectedPhotoList = RxList();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController address = TextEditingController();

  bool fieldValidation() {
    return (formKey.currentState?.validate() == true) &&
        (selectedPhotoList.firstOrNull != null);
  }

  void createProject() async {
    if (!fieldValidation()) {
      return;
    }
    Get.showSuccessSnackbar(
        getStorageRepository.read('supabaseUser').toString());
    var user = getStorageRepository.read('supabaseUser');
    var signInUser = UserModelSupabase.fromJson(user);
    supabaseSetupController
        .checkForDuplicateProject(projectName.text)
        .then((isDuplicate) async {
      if (!isDuplicate) {
        if (selectedPhotoList.firstOrNull != null) {
          List<File> files = selectedPhotoList
                  ?.map((files) => File(files.path ?? ''))
                  .toList() ??
              [];
          firebaseStorageController
              .uploadFile(files.first,
                  'thumbnail_projet_${projectName.text.toString().replaceAll(' ', '').trim()}.png')
              .then((thumbnailImageUrl) {
            hideProgressBar();
            var project = ProjectCreateModel(
              name: projectName.text.toString(),
              mobileNumber: mobileNumber.text.toString(),
              address: address.text.toString(),
              thumbnailImageUrl: thumbnailImageUrl,
              createdByUser: signInUser.id,
            );
            supabaseSetupController.createNewProject(project);
          });
        } else {
          // User canceled the picker
        }
      }
    });
  }

  void selectPhoto() async {
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
      List<File> filetemp =
          result.paths.map((path) => File(path ?? '')).toList();
      for (int i = 0; i < filetemp.length; i++) {
        int sizeInBytes = filetemp[i].lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb < 30) {
          selectedPhotoList.add(filetemp[i]);
        } else {
          Get.showErrorSnackbar('File size is more then 30 MB');
        }
      }
    } else {
      // User canceled the picker
    }
  }
}
