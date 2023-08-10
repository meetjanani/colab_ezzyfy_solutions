import 'dart:io';

import 'package:get/get.dart';

import '../model/create_project_response_model.dart';
import '../model/user_model_supabase.dart';
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

  Future<String> uploadUserProfileImageByUserId(
      File file,
      UserModelSupabase userModelSupabase,
      ) async {
    var userName = userModelSupabase.name.toString().replaceAll(' ', '').trim();
    var userId = userModelSupabase.id.toString().replaceAll(' ', '').trim();
    String? fileName =
        '${userId}_${userName}_${file?.path.split('/').last.replaceAll(' ', '').trim()}.png';
    var fileRef =
    DatabaseSchema.userProfileRef.child('/${userId}_$userName').child(fileName);
    await fileRef.delete();
    await fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }
}
