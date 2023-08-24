import 'dart:async';

import 'package:colab_ezzyfy_solutions/firebase_operation/firebase_auth_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

import '../../model/user_model.dart';
import '../../route/route.dart';

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
  FirebaseAuthController firebaseController = FirebaseAuthController.to;
  RxString pin = '0'.obs;
  RxInt seconds = 60.obs;
  Timer? timer;

  void registerUser() {
    if (!fieldValidation()) {
      Get.showErrorSnackbar('Please enter valid details.');
      return;
    } else if (!isSelect1.value) {
      Get.showErrorSnackbar(
          'Please approve Terms & Condition and Privacy Policy');
      return;
    }
    var mobileNumber = countryCodeController.text.toString() +
        mobileNumberController.text.toString();
    firebaseController.isLoginRequest = false;
    firebaseController.userRegisterData = UserModel(
      name: nameController.text.toString(),
      mobileNumber: mobileNumber,
      emailAddress: emailAddressController.text.toString(),
    ).toJson();
    firebaseController.fbRegister();
  }

  bool fieldValidation() {
    return formKey.currentState?.validate() == true;
  }

  void resend() {
    Get.back();
    Get.offNamed(AppRoute.login);
  }

  void startTimer() {
    seconds = 60.obs;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds.value--;
      } else {
        timer.cancel();
      }
    });
  }
}
