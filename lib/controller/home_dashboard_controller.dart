import 'dart:convert';
import 'dart:io';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/supabase_setup_controller.dart';
import '../model/project_create_model.dart';
import '../model/user_model_supabase.dart';
import '../shared/get_storage_repository.dart';

class HomeDashboardController extends GetxController {
  static HomeDashboardController get to => Get.find();
  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  SupabaseSetupController supabaseSetupController = SupabaseSetupController.to;

  void uploadFile() async {
    var user = GetStorageRepository(Get.find()).read('supabaseUser');
    var signInUser = UserModelSupabase.fromJson(user);
    supabaseSetupController
        .checkForDuplicateProject('Project Name2')
        .then((isDuplicate) async {
      if (!isDuplicate) {
        FilePickerResult? selectedPhoto = await selectPhoto();
        if (selectedPhoto != null) {
          List<File> files =
              selectedPhoto.paths.map((path) => File(path ?? '')).toList();
          firebaseStorageController
              .uploadFile(files.first, 'Project Name2.png')
              .then((thumbnailImageUrl) {
            hideProgressBar();
            var project = ProjectCreateModel(
              name: 'Project Name',
              mobileNumber: '1011',
              address: 'Rajkot Gujarat is project address',
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

  Future<FilePickerResult?> selectPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    return result;
  }
}
