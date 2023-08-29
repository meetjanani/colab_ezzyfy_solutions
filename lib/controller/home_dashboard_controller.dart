import 'dart:io';
import 'dart:typed_data';

import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_sketcher/image_sketcher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../firebase_operation/firebase_auth_controller.dart';
import '../firebase_operation/firebase_storage_controller.dart';
import '../firebase_operation/project_controller_supabase.dart';
import '../model/create_project_response_model.dart';
import '../model/project_attchments_request_model.dart';
import '../model/project_attchments_response_model.dart';
import '../model/user_model_supabase.dart';
import '../resource/Image_picker_widget.dart';
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
  RxList<UserModelSupabase> starredPeople = RxList();
  Rx<String> userName = "Ronaldo".obs;
  RxList<File> selectedPhoto = RxList();
  RxList<File> projectAttachmentRequestModel = RxList();
  RxList<ProjectAttachmentsRequestModel> projectAttachmentsListSupabase =
      RxList();
  RxList<ProjectAttachmentsResponseModel> projectAttachmentsList = RxList();
  RxBool projectsLoader = false.obs;
  RxBool projectFeedsLoader = false.obs;
  RxBool isProfilePictureUpload = false.obs;
  UserModelSupabase? userModelSupabase = null;

  Future<bool> init({bool showLoader = false}) async {
    if (showLoader){
      projectsLoader.value = true;
      projectFeedsLoader.value = true;
    }
    await fetchUserProfile();
    await fetchProject();
    await fetchFeed();
    projectsLoader.value = false;
    return true;
  }

  Future<void> fetchUserProfile() async {
    userModelSupabase = await getUserModel();
    userName.value = userModelSupabase?.name ?? '';
  }

  Future<void> fetchProject() async {
    var response = await projectControllerSupabase.getProjectsByUserId(userModelSupabase?.id ?? 0);
    response.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
    projectList
      ..clear()
      ..addAll(response);
    projectsLoader.value = false;
    fetchProjectUsers();
  }

  Future<void> fetchProjectUsers() async {
    var response = await projectControllerSupabase.getAssignedProjectUsers(projectList.value);
    starredPeople
      ..clear()
      ..addAll(response);
    projectsLoader.value = false;
  }

  Future<void> fetchFeed() async {
    var response = await projectControllerSupabase.getRecentOwnProjectAttachments(userModelSupabase?.id ?? 0);
    projectAttachmentsList
      ..clear()
      ..addAll(response);
    projectFeedsLoader.value = false;
  }

  Future<void> imagesketer(CreateProjectResponseModel project, BuildContext context) async {
    final _imageKey = GlobalKey<ImageSketcherState>();
    final _key = GlobalKey<ScaffoldState>();
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    var file =  File(photo!.path);
    await ImageSketcher.file(file, key: _imageKey);
    print('Hello');
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
    showProgress();
    projectsLoader.value = true;
    projectAttachmentsListSupabase.clear();
    selectedPhoto.clear();
    List<File> result = await ImagePickerWidget().pickImageFromGallery(context);
    selectedPhoto.value.addAll(result);
    if (selectedPhoto.value.isNotEmpty) {
      int imageCount = selectedPhoto.value.length;
      for (int i = 0; i < imageCount; i++) {
        await uploadFileOverFirebase(project);
      }
      hideProgressBar();
      // insert into supabase in one go
      await projectControllerSupabase.createProjectAttachment(projectAttachmentsListSupabase.value);
      init();
      projectsLoader.value = false;
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
          projectsLoader.value = true;
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
        createdByUser: userModelSupabase?.id ?? project.createdByUser,
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
    // stre into local shared preference
    await firebaseAuthController.getUserById(userModelSupabase!.id);
    selectedPhoto.value.removeAt(0);
    await init();
    projectsLoader.value = false;
  }
}
