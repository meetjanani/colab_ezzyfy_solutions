import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colab_ezzyfy_solutions/controller/Auth/firebase_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/route.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  String countryCode = '+91';
  FirebaseController firebaseController = FirebaseController.to;

  RxBool passwordVisibal = RxBool(false);

  void signIn() {
    if (fieldValidation()) {
      firebaseController.isLoginRequest = true;
      firebaseController.fbLogin(countryCode + mobileNumber.text.toString());
    }
  }

  bool fieldValidation() {
    return formKey.currentState?.validate() == true;
  }
}
