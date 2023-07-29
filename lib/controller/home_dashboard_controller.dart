import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../firebase_operation/firebase_auth_controller.dart';

class HomeDashboardController extends GetxController {
  static HomeDashboardController get to => Get.find();
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
}
