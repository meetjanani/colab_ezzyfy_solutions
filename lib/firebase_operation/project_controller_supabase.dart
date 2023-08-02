import 'dart:convert';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/project_create_model.dart';
import '../resource/database_schema.dart';

class ProjectControllerSupabase {
  static ProjectControllerSupabase get to => Get.find();

  Future<List<ProjectCreateModel>> getProjectsByUserId(int userId) async {
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

  Future<ProjectCreateModel> getProjectById(int projectId) async {
    showProgress();
    var projectResponse = await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .select('*')
        .eq(DatabaseSchema.projectId, projectId)
        .limit(1);
    hideProgressBar();
    return ProjectCreateModel.fromJsonList(projectResponse)[0];
  }

  void addOrRemoveUserFromProject(int userId, int projectId) async {
    showProgress();
    var projectById = await getProjectById(projectId);
    var assignedUserList = projectById.assignedUser.toString().split(',');
    if (!assignedUserList.contains(userId.toString())) {
      assignedUserList.add(userId.toString());
    } else {
      assignedUserList.remove(userId.toString());
    }
    await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .update(
            {DatabaseSchema.projectAssignedUser: assignedUserList.join(',')})
        .eq(DatabaseSchema.projectId, projectId)
        .select();
    hideProgressBar();
    getAssignedUserByProject(projectId);
  }

  void getAssignedUserByProject(int projectId) async {
    showProgress();
    var projectById = await getProjectById(projectId);
    projectById.assignedUser.split(',');
    var userResponse = await Supabase.instance.client
        .from(DatabaseSchema.usersTable)
        .select('*')
        .in_(DatabaseSchema.usersId, projectById.assignedUser.split(','));
    hideProgressBar();
  }
}
