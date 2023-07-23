import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../binding/firebase/firebase_storage_controller.dart';

class HomeDashboardController extends GetxController {
  static HomeDashboardController get to => Get.find();
  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;

  void uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path ?? '')).toList();
      files.first.rename('project_file_1');
      firebaseStorageController.uploadFile(files.first, 'file_name.png');
    } else {
      // User canceled the picker
    }
  }
}
