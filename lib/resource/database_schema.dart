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
  static const String userCreateAt = "createAt";

  static const String projectTable = "projects";
  static const String projectId = "id";
  static const String projectName = "name";
  static const String projectMobileNumber = "mobileNumber";
  static const String projectMobileNumberCol = "address";
  static const String projectThumbnailImageUrl = "thumbnailImageUrl";
  static const String projectCreateAt = "createAt";

  // Firebase Storage
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static Reference firebaseStorageRef = firebaseStorage.ref();
  static Reference teamRef = firebaseStorage.ref().child('teams');
}







