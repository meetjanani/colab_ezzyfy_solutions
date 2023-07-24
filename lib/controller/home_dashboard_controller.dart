import 'dart:io';

import 'package:colab_ezzyfy_solutions/firebase_operation/firebase_project_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../firebase_operation/firebase_storage_controller.dart';
import '../model/project_create_model.dart';

class HomeDashboardController extends GetxController {
  static HomeDashboardController get to => Get.find();
  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  FirebaseProjectController firebaseProjectController =
      FirebaseProjectController.to;

  void uploadFile() async {
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
        firebaseProjectController.createNewProject(ProjectCreateModel(
          projectName: 'Project Name',
          projectMobileNumber: '1011',
          projectEmailAddress: 'Rajkot Gujarat is project address',
          createdByUser: 'meet',
          projectThumbnailImageUrl: thumbnailImageUrl,
        ));
      });
    } else {
      // User canceled the picker
    }
  }
}
