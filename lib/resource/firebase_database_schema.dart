import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseDatabaseSchema extends GetxController {
  static FirebaseDatabaseSchema get to => Get.find();

  // Document name will be +91{10 digit MobileNumber}
  static const String usersTable = "users";
  static const String emailAddressCol = "emailAddress";
  static const String nameCol = "name";
  static const String phoneNumberCol = "phoneNumber";
  static const String createAtCol = "createAt";

  static const String projectTable = "projects";
  static const String projectNameCol = "projectName";
  static const String projectMobileNumberCol = "projectMobileNumber";
  static const String projectEmailAddressCol = "projectEmailAddress";
  static const String projectThumbnailImageUrlCol = "projectThumbnailImageUrl";

  // Firebase Storage
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static Reference firebaseStorageRef = firebaseStorage.ref();
  static Reference teamRef = firebaseStorage.ref().child('teams');
}







