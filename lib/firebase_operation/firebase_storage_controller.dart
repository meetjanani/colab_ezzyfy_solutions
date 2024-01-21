import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/create_project_response_model.dart';
import '../model/project_attchments_response_model.dart';
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
  Future<void> deleteFile(
      ProjectAttachmentsResponseModel attachmentsResponseModel, String projectName) async {
    if(attachmentsResponseModel.projectAttachmentUrl.isNotEmpty){
      var fileUrl = Uri.decodeFull(attachmentsResponseModel.projectAttachmentUrl).replaceAll(new RegExp(r'(\?alt).*'), '');
      var fileRef =
      DatabaseSchema.projectRef.child('/$projectName').child(fileUrl.split('/').last);
      await fileRef.delete();
    }
    if(attachmentsResponseModel.videoUrl?.isNotEmpty == true){
      var fileUrl = Uri.decodeFull(attachmentsResponseModel.videoUrl!).replaceAll(new RegExp(r'(\?alt).*'), '');
      var fileRef =
      DatabaseSchema.projectRef.child('/$projectName').child(fileUrl.split('/').last);
      await fileRef.delete();
    }

    var response = await Supabase.instance.client.from(DatabaseSchema.projectAttachmentsTable)
        .delete()
        .eq(DatabaseSchema.projectId, attachmentsResponseModel.id)
        .select();
  }

  Future<String> uploadImageByProjectId(
    File file,
    CreateProjectResponseModel project,
  ) async {
    var projectName = project.name.toString().replaceAll(' ', '').trim();
    String? fileName =
        '${projectName}_${file?.path.split('/').last.replaceAll(' ', '').trim()}';
    var fileRef =
        DatabaseSchema.projectRef.child('/$projectName').child(fileName);
    await fileRef.putFile(file, SettableMetadata(contentType: 'video/mp4') );
    return await fileRef.getDownloadURL();
  }

  Future<String> uploadUserProfileImageByUserId(
      File file,
      UserModelSupabase userModelSupabase,
      ) async {
    var userName = userModelSupabase.name.toString().replaceAll(' ', '').trim();
    var userId = userModelSupabase.id.toString().replaceAll(' ', '').trim();
    String? fileName = '${userId}_${userName}.png';
    var folderRef =
    DatabaseSchema.userProfileRef.child('/${userId}_$userName');
    var fileRef = folderRef.child(fileName);
    try {
      await fileRef.delete();
    } catch (e) {
      print("error");
    }
    await fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }
}
