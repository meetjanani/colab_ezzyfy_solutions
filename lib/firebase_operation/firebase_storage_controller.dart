import 'dart:io';

import 'package:get/get.dart';

import '../resource/firebase_database_schema.dart';

class FirebaseStorageController extends GetxController {
  static FirebaseStorageController get to => Get.find();

  Future<String> uploadFile(File file, String fileName) async {
    var fileRef = FirebaseDatabaseSchema.teamRef.child(fileName);
    await fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }
}
