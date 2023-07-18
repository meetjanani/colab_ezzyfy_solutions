import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colab_ezzyfy_solutions/controller/Auth/firebase_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

import '../../ui/pages/Auth/otp_bottomsheet.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  RxBool passwordVisibal = RxBool(false);
  RxBool passwordVisibal2 = RxBool(false);
  RxBool isSelect1 = RxBool(false);

  OtpFieldController otpController = OtpFieldController();
  FirebaseController firebaseController = FirebaseController.to;
  RxString pin = '0'.obs;

  void registerUser() {
    if (!isSelect1.value) {
      print("Please approve Terms & Condition and Privacy Policy");
      return;
    }
    firebaseController.isLoginRequest = false;
    firebaseController.userRegisterData = {
    'name': nameController.text.toString(),
    'phoneNumber': mobileNumberController.text.toString(),
    'emailAddress': emailAddressController.text.toString(),
    };
    firebaseController.fbLogin(mobileNumberController.text.toString());

  }


}
