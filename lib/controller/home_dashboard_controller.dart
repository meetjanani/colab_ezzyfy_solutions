import 'dart:io';
import 'dart:typed_data';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_request_model.dart';
import '../model/project_attchments_response_model.dart';
import '../model/user_model_supabase.dart';
import '../resource/database_schema.dart';
import '../resource/session_string.dart';
import '../shared/colab_shared_preference.dart';

class HomeDashboardController extends GetxController {
  static HomeDashboardController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  FirebaseStorageController firebaseStorageController =
      FirebaseStorageController.to;
  FirebaseAuthController firebaseAuthController = FirebaseAuthController.to;
  ProjectControllerSupabase projectControllerSupabase =
      ProjectControllerSupabase.to;
  RxList<CreateProjectResponseModel> projectList = RxList();
  Rx<String> userName = "Ronaldo".obs;
  RxList<File> selectedPhoto = RxList();
  RxList<File> projectAttachmentRequestModel = RxList();
  RxList<ProjectAttachmentsRequestModel> projectAttachmentsListSupabase =
      RxList();
  RxList<ProjectAttachmentsResponseModel> projectAttachmentsList = RxList();
  RxBool projectLoader = false.obs;
  RxBool isProfilePictureUpload = false.obs;
  UserModelSupabase? userModelSupabase = null;

  Future<bool> init() async {
    projectLoader.value = true;
    userModelSupabase = await getUserModel();
    userName.value = userModelSupabase?.name ?? '';
    await Future.delayed(Duration(seconds: 2));
    await fetchProject();
    await fetchFeed();
    return true;
  }

  Future<void> fetchProject() async {
    projectLoader.value = true;
    await Future.delayed(Duration(seconds: 2));
    projectList
      ..clear()
      ..addAll(await projectControllerSupabase.getProjectsByUserId(userModelSupabase?.id ?? 0));
    projectList.value.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
    projectLoader.value = false;
  }

  Future<void> fetchFeed() async {
    projectLoader.value = true;
    projectAttachmentsList
      ..clear()
      ..addAll(
          await projectControllerSupabase.getRecentTenProjectAttachments());
    projectLoader.value = false;
  }

  // Image Edit flow
  /*Future<Uint8List> addImageFromCamera(CreateProjectResponseModel project, BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    var file =  File(photo!.path);
    Uint8List bytes = file.readAsBytesSync();
    final editedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(
          image: bytes, // <-- Uint8List of image
        ),
      ),
    );
    var fileEdited = File.fromRawPath(editedImage);
    selectedPhoto
    ..clear()
    ..add(fileEdited);
    await uploadFileOverFirebase(project);
    return bytes;
  }*/

  void addImage(CreateProjectResponseModel project, BuildContext context) async {
    projectAttachmentsListSupabase.clear();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'jpeg',
      ],
    );
    if (result != null) {
      selectedPhoto.clear();
      List<File> fileTemp =
          result.paths.map((path) => File(path ?? '')).toList();
      for (int i = 0; i < fileTemp.length; i++) {
        int sizeInBytes = fileTemp[i].lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb < 30) {
          selectedPhoto.add(fileTemp[i]);
          await uploadFileOverFirebase(project);
        } else {
          Get.showErrorSnackbar('File size is more then 30 MB');
        }
      }
      // insert into supabase in one go
      projectControllerSupabase.createProjectAttachment(projectAttachmentsListSupabase.value);
    } else {
      // User canceled the picker
    }
  }

  void changeProfilePicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'jpeg',
      ],
    );
    if(result != null) {
      selectedPhoto.clear();
      List<File> fileTemp =
      result.paths.map((path) => File(path ?? '')).toList();
      for (int i = 0; i < fileTemp.length; i++) {
        int sizeInBytes = fileTemp[i].lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb < 30) {
          selectedPhoto.add(fileTemp[i]);
          projectLoader.value = true;
          await uploadUserProfileOverFirebase();
        } else {
          Get.showErrorSnackbar('File size is more then 30 MB');
        }
      }
    }
  }

  Future<void> uploadFileOverFirebase(CreateProjectResponseModel project) async {
    File fileToUpload = File(selectedPhoto.value?.first?.path ?? '');
    var projectAttachmentUrl = await firebaseStorageController.uploadImageByProjectId(
        fileToUpload, project,);
    selectedPhoto.value.removeAt(0);
    projectAttachmentsListSupabase.add(ProjectAttachmentsRequestModel(
        projectId: project.id,
        createdByUser: project.createdByUser,
        projectAttachmentUrl: projectAttachmentUrl));
  }

  Future<void> uploadUserProfileOverFirebase() async {
    File fileToUpload = File(selectedPhoto.value?.first?.path ?? '');
    userModelSupabase!.profilePictureUrl = await firebaseStorageController.uploadUserProfileImageByUserId(
      fileToUpload, userModelSupabase!,);

    setColabKey(userProfilePictureSessionStorage, userModelSupabase!.profilePictureUrl);

    await Supabase.instance.client
        .from(DatabaseSchema.usersTable)
        .update(
        {DatabaseSchema.userProfilePictureUrl: userModelSupabase!.profilePictureUrl})
        .eq(DatabaseSchema.usersId, userModelSupabase!.id)
        .select();
    await firebaseAuthController.getUserById(userModelSupabase!.id);
    selectedPhoto.value.removeAt(0);
    init();
    projectLoader.value = false;
  }
}
