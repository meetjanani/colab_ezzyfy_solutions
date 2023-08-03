import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/project_create_model.dart';

class HomeDashboardController extends GetxController {
  static HomeDashboardController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<ProjectCreateModel> projectList = RxList();

  void fetchProject() async {
    await Future.delayed(Duration(seconds: 2));
    projectList
      ..clear()
      ..addAll(await projectControllerSupabase.getProjectsByUserId(14));
  }
}
