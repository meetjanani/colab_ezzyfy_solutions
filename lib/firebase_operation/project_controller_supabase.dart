import 'package:colab_ezzyfy_solutions/model/user_model_supabase.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/resource/image.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/all_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/create_project_request_model.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_request_model.dart';
import '../model/project_attchments_response_model.dart';
import '../resource/constant.dart';
import '../resource/database_schema.dart';

class ProjectControllerSupabase {
  static ProjectControllerSupabase get to => Get.find();

  //This can be use for Admin Role
  Future<List<CreateProjectResponseModel>> getAllProjects() async {
    final response = await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .select('*')
        .order(DatabaseSchema.projectupdatedAt, ascending: false);
    var projectList = CreateProjectResponseModel.fromJsonList(response);
    return projectList;
  }

  Future<List<CreateProjectResponseModel>> getProjectsByUserId(int userId) async {
    List<CreateProjectResponseModel> allProjectList = [];
    final response = await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .select('*')
        .textSearch(DatabaseSchema.projectAssignedUser, userId.toString())
        .order(DatabaseSchema.projectupdatedAt, ascending: false);
    final responseCreatedByUser = await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .select('*')
        .eq(DatabaseSchema.projectCreatedByUser, userId)
        .order(DatabaseSchema.projectupdatedAt, ascending: false);
    allProjectList.addAll(CreateProjectResponseModel.fromJsonList(response));
    CreateProjectResponseModel.fromJsonList(responseCreatedByUser)
        .forEach((newProject) {
      if (!allProjectList
          .where((element) => element.id == newProject.id)
          .isNotEmpty) {
        allProjectList.add(newProject);
      }
    });
    return allProjectList.toList();
  }

  Future<List<UserModelSupabase>> getAssignedProjectUsers(
      List<CreateProjectResponseModel> projectLists) async {
    List<int> assignedUserIds = [];
    projectLists.forEach((userIds) {
      userIds.assignedUser.split(',').forEach((userId) {
        if (!assignedUserIds.contains(int.parse(userId))) {
          assignedUserIds.add(int.parse(userId));
        }
      });
    });
    List<UserModelSupabase> allAssignedUsersList = [];
    // select * from users where id IN (38,22)
    final response = await Supabase.instance.client
        .from(DatabaseSchema.usersTable)
        .select()
        .in_(DatabaseSchema.usersId, assignedUserIds);
    allAssignedUsersList.addAll(UserModelSupabase.fromJsonList(response));
    return allAssignedUsersList.toList();
  }

  // Get a reference your Supabase client
  Future<bool> checkForDuplicateProject(String projectName) async {
    final duplicateProject = await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .select('*')
        .eq(DatabaseSchema.projectName, projectName)
        .limit(1);
    if (duplicateProject.length > 0) {
      Get.showErrorSnackbar("This project is already exists");
    }
    return duplicateProject.length > 0;
  }

  void createNewProject(CreateProjectRequestModel projectCreateModel) async {
    await Supabase.instance.client.from(DatabaseSchema.projectTable).upsert([
      projectCreateModel.toJson(),
    ]);
    Get.back(result: true); // dismiss progress bar
    Get.back(result: true); // navigate back screen
    showDialog(
      context: Get.context!,

      builder: (BuildContext context) {

        return Dialog(
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(child: Image.asset(alertProjectCreateSuccessDialogImg),
              onTap: (){
                Get.back(result: true);
              },),
              /*text('Congratulation', Colors.black, 28, FontWeight.w600),
              SizedBox(height: 5,),
              text('Project Created', Colors.grey, 16, FontWeight.w400),
              text('Successfully', Colors.grey, 16, FontWeight.w400),
              SizedBox(height: 10,),
              blueButton('Done', (){Get.back(result: true);},52,Get.width/2),
              SizedBox(height: 10,),*/
            ],
          ),
        );

      },
    );
    //Get.showSuccessSnackbar('New Project Created successfully.');

  }

  Future<CreateProjectResponseModel> getProjectById(int projectId) async {
    var projectResponse = await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .select('*')
        .eq(DatabaseSchema.projectId, projectId)
        .limit(1);
    return CreateProjectResponseModel.fromJsonList(projectResponse)[0];
  }

  Future<List<UserModelSupabase>> addOrRemoveUserFromProject(int userId, int projectId) async {
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
    return await getAssignedUserByProject(projectId);
  }

  Future<List<UserModelSupabase>> addOrRemoveAssignedSiteVisitUserFromProject(int userId, int projectId) async {
    var projectById = await getProjectById(projectId);
    var assignedSiteVisitUserList = projectById.assignedSiteVisitUser.toString().split(',').where((element) => element.length > 0).toList();
    if (!assignedSiteVisitUserList.contains(userId.toString())) {
      assignedSiteVisitUserList.add(userId.toString());
    } else {
      assignedSiteVisitUserList.remove(userId.toString());
    }
    await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .update(
        {DatabaseSchema.projectAssignedSiteVisitUser: assignedSiteVisitUserList.join(',')})
        .eq(DatabaseSchema.projectId, projectId)
        .select();
    return await getAssignedSiteVisitUserByProject(projectId);
  }

  Future<List<UserModelSupabase>> fetAllSystemUsers() async {
    var userResponse = await Supabase.instance.client
        .from(DatabaseSchema.usersTable)
        .select('*');
    return UserModelSupabase.fromJsonList(userResponse);
  }

  Future<List<UserModelSupabase>> getAssignedUserByProject(int projectId) async {
    var projectById = await getProjectById(projectId);
    var userResponse = await Supabase.instance.client
        .from(DatabaseSchema.usersTable)
        .select('*')
        .in_(DatabaseSchema.usersId, projectById.assignedUser.split(','));
    return UserModelSupabase.fromJsonList(userResponse);
  }

  Future<List<UserModelSupabase>> getAssignedSiteVisitUserByProject(int projectId) async {
    var projectById = await getProjectById(projectId);
    var userResponse = await Supabase.instance.client
        .from(DatabaseSchema.usersTable)
        .select('*')
        .in_(DatabaseSchema.usersId, projectById.assignedSiteVisitUser.split(','));
    return UserModelSupabase.fromJsonList(userResponse);
  }

  Future<void> createProjectAttachment(
      List<ProjectAttachmentsRequestModel> projectAttachment) async {
    showProgress();
    var response = await Supabase.instance.client
        .from(DatabaseSchema.projectAttachmentsTable)
        .insert(ProjectAttachmentsRequestModel.toJsonListProject(projectAttachment)).select();
    await updateModifiedTimeProjectById(projectAttachment.first.projectId);
    hideProgressBar();
    Get.showSuccessSnackbar('Image uploaded successfully.');
  }

  Future<void> updateModifiedTimeProjectById(int projectId) async {
    await Supabase.instance.client
        .from(DatabaseSchema.projectTable)
        .update(
        {DatabaseSchema.projectupdatedAt: DateTime.now().toString()})
        .eq(DatabaseSchema.projectId, projectId)
        .select();
  }

  Future<List<ProjectAttachmentsResponseModel>> getProjectAttachments(int projectId) async {
    final response = await Supabase.instance.client
        .from(DatabaseSchema.projectAttachmentsTable)
        .select('*, users:createdByUser ( name, profilePictureUrl ), projects:projectId ( name )')
        .eq(DatabaseSchema.projectAttachmentsProjectId, projectId);
    var projectList = ProjectAttachmentsResponseModel.fromJsonList(response);
    return projectList;
  }

  Future<List<ProjectAttachmentsResponseModel>> getRecentOwnProjectAttachments(int currentUserId) async {
    final response = await Supabase.instance.client
        .from(DatabaseSchema.projectAttachmentsTable)
        .select('*, users:createdByUser ( name, profilePictureUrl ), projects:projectId ( name )')
    .eq(DatabaseSchema.projectAttachmentsCreatedByUser, currentUserId)
        .limit(10)
        .order(DatabaseSchema.projectAttachmentsCreateAt, ascending: false);
    var projectList = ProjectAttachmentsResponseModel.fromJsonList(response);
    return projectList;
  }

  Future<List<ProjectAttachmentsResponseModel>> getAssignedProjectWiseAttachments(int currentUserId) async {
    //TODO: Fetch feeds only uploaded by current user.
    final response = await Supabase.instance.client
        .from(DatabaseSchema.projectAttachmentsTable)
        .select('*, users:createdByUser ( name, profilePictureUrl ), projects:projectId ( name )')
        .eq(DatabaseSchema.projectAttachmentsCreatedByUser, currentUserId)
        .limit(10)
        .order(DatabaseSchema.projectAttachmentsCreateAt, ascending: false);
    var projectList = ProjectAttachmentsResponseModel.fromJsonList(response);
    return projectList;
  }

  Future<List<ProjectAttachmentsResponseModel>> getAssignedProjectAttachmentBySiteId(String attachmentIds) async {
    var userResponse = await Supabase.instance.client
        .from(DatabaseSchema.projectAttachmentsTable)
        .select('*, users:createdByUser ( name, profilePictureUrl ), projects:projectId ( name )')
        .in_(DatabaseSchema.usersId, attachmentIds.split(','));
    return ProjectAttachmentsResponseModel.fromJsonList(userResponse);
  }
}
