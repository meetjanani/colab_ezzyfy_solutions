import 'dart:io';

import 'package:get/get.dart';

import '../model/create_project_response_model.dart';
import '../resource/database_schema.dart';

class FirebaseStorageController extends GetxController {
  static FirebaseStorageController get to => Get.find();

  Future<String> uploadFile(
      File file, String fileName, String projectName) async {
    var fileRef =
        DatabaseSchema.projectRef.child('/$projectName').child(fileName);
    await fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }

  Future<String> uploadImageByProjectId(
    File file,
    CreateProjectResponseModel project,
  ) async {
    var projectName = project.name.toString().replaceAll(' ', '').trim();
    String? fileName =
        '${projectName}_${file?.path.split('/').last.replaceAll(' ', '').trim()}.png';
    var fileRef =
        DatabaseSchema.projectRef.child('/$projectName').child(fileName);
    await fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }
}
