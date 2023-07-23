import 'package:get/get.dart';

class FirebaseDatabaseSchema extends GetxController {
  static FirebaseDatabaseSchema get to => Get.find();

  // Document name will be +91{10 digit MobileNumber}
  static const String usersTable = "users";
  static const String emailAddressCol = "emailAddress";
  static const String nameCol = "name";
  static const String phoneNumberCol = "phoneNumber";
}







