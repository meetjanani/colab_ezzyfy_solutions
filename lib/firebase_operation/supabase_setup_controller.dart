import 'dart:ffi';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/project_create_model.dart';
import '../resource/database_schema.dart';

class SupabaseSetupController {
  static SupabaseSetupController get to => Get.find();

  // Get a reference your Supabase client
  Future<bool> checkForDuplicateProject(String projectName) async {
    showProgress();
    final duplicateProject = await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .select('*')
        .eq(DatabaseSchema.projectName, projectName)
        .limit(1);
    hideProgressBar();
    if (duplicateProject.length > 0) {
      Get.showErrorSnackbar("Duplicate Project");
    }
    return duplicateProject.length > 0;
  }

  void createNewProject(ProjectCreateModel projectCreateModel) async {
    showProgress();
    final List<Map<String, dynamic>> project = await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .upsert([
      projectCreateModel.toJson(),
    ]).select();
    hideProgressBar();
    Get.showSuccessSnackbar('New Project Creates successfully.');
  }
}
