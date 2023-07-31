import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/project_create_model.dart';
import '../resource/database_schema.dart';

class ProjectControllerSupabase {
  static ProjectControllerSupabase get to => Get.find();

  Future<List<ProjectCreateModel>> getAllProjectByLoginUser(int userId) async {
    showProgress();
    final response = await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .select('*')
        .eq(DatabaseSchema.projectCreatedByUser, userId);

    var projectList = ProjectCreateModel.fromJsonList(response);
    hideProgressBar();
    return projectList;
  }

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
    await Supabase.instance.client.from(DatabaseSchema.projectTable).upsert([
      projectCreateModel.toJson(),
    ]);
    hideProgressBar();
    Get.showSuccessSnackbar('New Project Created successfully.');
  }
}
