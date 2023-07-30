import 'dart:io';

import 'package:get/get.dart';

import '../resource/database_schema.dart';

class FirebaseStorageController extends GetxController {
  static FirebaseStorageController get to => Get.find();

  Future<String> uploadFile(File file, String fileName, String projectName) async {
    var fileRef = DatabaseSchema.projectRef.child('/$projectName').child(fileName);
    await fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }
}
