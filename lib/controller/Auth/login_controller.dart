import 'package:colab_ezzyfy_solutions/firebase_operation/firebase_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  FirebaseAuthController firebaseController = FirebaseAuthController.to;

  RxBool passwordVisibal = RxBool(false);

  void signIn() {
    if (fieldValidation()) {
      firebaseController.isLoginRequest = true;
      firebaseController.fbLogin(
          countryCodeController.text.toString() + mobileNumber.text.toString());
    }
  }

  bool fieldValidation() {
    return formKey.currentState?.validate() == true;
  }
}
