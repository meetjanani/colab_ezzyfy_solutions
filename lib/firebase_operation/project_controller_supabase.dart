import 'package:colab_ezzyfy_solutions/model/user_model_supabase.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/create_project_request_model.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_request_model.dart';
import '../model/project_attchments_response_model.dart';
import '../resource/database_schema.dart';

class ProjectControllerSupabase {
  static ProjectControllerSupabase get to => Get.find();

  Future<List<CreateProjectResponseModel>> getProjectsByUserId(int userId) async {
    showProgress();
    final response = await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .select('*')
        .eq(DatabaseSchema.projectCreatedByUser, userId);

    var projectList = CreateProjectResponseModel.fromJsonList(response);
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

  void createNewProject(CreateProjectRequestModel projectCreateModel) async {
    showProgress();
    await Supabase.instance.client.from(DatabaseSchema.projectTable).upsert([
      projectCreateModel.toJson(),
    ]);
    hideProgressBar();
    Get.showSuccessSnackbar('New Project Created successfully.');
  }

  Future<CreateProjectResponseModel> getProjectById(int projectId) async {
    showProgress();
    var projectResponse = await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .select('*')
        .eq(DatabaseSchema.projectId, projectId)
        .limit(1);
    hideProgressBar();
    return CreateProjectResponseModel.fromJsonList(projectResponse)[0];
  }

  Future<List<UserModelSupabase>> addOrRemoveUserFromProject(int userId, int projectId) async {
    showProgress();
    var projectById = await getProjectById(projectId);
    var assignedUserList = projectById.assignedUser.toString().split(',').where((element) => element.length > 0).toList();
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
    return await getAssignedUserByProject(projectId);
  }

  Future<List<UserModelSupabase>> fetAllSystemUsers() async {
    showProgress();
    var userResponse = await Supabase.instance.client
        .from(DatabaseSchema.usersTable)
        .select('*');
    hideProgressBar();
    return UserModelSupabase.fromJsonList(userResponse);
  }

  Future<List<UserModelSupabase>> getAssignedUserByProject(int projectId) async {
    showProgress();
    var projectById = await getProjectById(projectId);
    var userResponse = await Supabase.instance.client
        .from(DatabaseSchema.usersTable)
        .select('*')
        .in_(DatabaseSchema.usersId, projectById.assignedUser.split(','));
    hideProgressBar();
    return UserModelSupabase.fromJsonList(userResponse);
  }

  void createProjectAttachment(
      List<ProjectAttachmentsRequestModel> projectAttachment) async {
    showProgress();
    await Supabase.instance.client
        .from(DatabaseSchema.projectAttachmentsTable)
        .insert(ProjectAttachmentsRequestModel.toJsonListProject(projectAttachment));
    hideProgressBar();
    Get.showSuccessSnackbar('Image uploaded successfully.');
  }

  Future<List<ProjectAttachmentsResponseModel>> getProjectAttachments(int projectId) async {
    showProgress();
    final response = await Supabase.instance.client
        .from(DatabaseSchema.projectAttachmentsTable)
        .select('*')
        .eq(DatabaseSchema.projectAttachmentsProjectId, projectId);
    var projectList = ProjectAttachmentsResponseModel.fromJsonList(response);
    hideProgressBar();
    return projectList;
  }
}
