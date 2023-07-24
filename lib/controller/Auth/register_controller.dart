import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colab_ezzyfy_solutions/binding/firebase/firebase_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/resource/firebase_database_schema.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

import '../../model/user_model.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  RxBool passwordVisibal = RxBool(false);
  RxBool passwordVisibal2 = RxBool(false);
  RxBool isSelect1 = RxBool(false);

  OtpFieldController otpController = OtpFieldController();
  FirebaseController firebaseController = FirebaseController.to;
  RxString pin = '0'.obs;

  void registerUser() {
    if (!fieldValidation()) {
      Get.showErrorSnackbar('Please enter valid details.');
      return;
    } else if (!isSelect1.value) {
      Get.showErrorSnackbar(
          'Please approve Terms & Condition and Privacy Policy');
      return;
    }
    firebaseController.isLoginRequest = false;
    firebaseController.userRegisterData = UserModel(
      name: nameController.text.toString(),
      phoneNumber: mobileNumberController.text.toString(),
      emailAddress: emailAddressController.text.toString(),
    ).toJson();
    firebaseController.fbLogin(countryCodeController.text.toString() +
        mobileNumberController.text.toString());
  }

  bool fieldValidation() {
    return formKey.currentState?.validate() == true;
  }
}
