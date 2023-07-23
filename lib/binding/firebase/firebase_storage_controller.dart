import 'dart:io';

import 'package:get/get.dart';

import '../../resource/firebase_database_schema.dart';
class FirebaseStorageController extends GetxController {
  static FirebaseStorageController get to => Get.find();

  void uploadFile(File file, String fileName) {
    FirebaseDatabaseSchema.teamRef.child(fileName).putFile(file);
  }
}
