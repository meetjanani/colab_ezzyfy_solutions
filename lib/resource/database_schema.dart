import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class DatabaseSchema extends GetxController {
  static DatabaseSchema get to => Get.find();

  // Document name will be +91{10 digit MobileNumber}
  static const String usersTable = "users";
  static const String usersId = "id";
  static const String userName = "name";
  static const String userEmailAddress = "emailAddress";
  static const String userMobileNumber = "mobileNumber";
  static const String userIsAdmin = "isAdmin";
  static const String userCreateAt = "createAt";
  static const String userProfilePictureUrl = "profilePictureUrl";

  static const String projectTable = "projects";
  static const String projectId = "id";
  static const String projectName = "name";
  static const String projectMobileNumberCol = "address";
  static const String projectThumbnailImageUrl = "thumbnailImageUrl";
  static const String projectCreatedByUser = "createdByUser";
  static const String projectCreateAt = "createAt";
  static const String projectupdatedAt = "updatedAt";
  static const String projectAssignedUser = "assignedUser";

  static const String projectAttachmentsTable = "projectAttachments";
  static const String projectAttachmentsId = "id";
  static const String projectAttachmentsProjectId = "projectId";
  static const String projectAttachmentsCreatedByUser = "createdByUser";
  static const String projectAttachmentsProjectAttachmentUrl = "projectAttachmentUrl";
  static const String projectAttachmentsCreateAt = "createAt";

  // Firebase Storage
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static Reference firebaseStorageRef = firebaseStorage.ref();
  static Reference projectRef = firebaseStorage.ref().child('projects');
  static Reference userProfileRef = firebaseStorage.ref().child('userProfiles');
}







