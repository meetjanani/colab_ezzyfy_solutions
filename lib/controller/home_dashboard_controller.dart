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
  FirebaseAuthController firebaseAuthController =
      FirebaseAuthController.to;
  SupabaseSetupController supabaseSetupController =
      SupabaseSetupController.to;

  void uploadFile() async {
    var user = GetStorageRepository(Get.find()).read('supabaseUser');
    var signInUser = UserModelSupabase.fromJson(user);
    showProgress();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path ?? '')).toList();
      files.first.rename('project_file_1');
      firebaseStorageController
          .uploadFile(files.first, 'file_name.png')
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
}
