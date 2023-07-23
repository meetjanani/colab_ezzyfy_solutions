import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colab_ezzyfy_solutions/binding/firebase/firebase_controller.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/route.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  var formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  FirebaseController firebaseController = FirebaseController.to;

  RxBool passwordVisibal = RxBool(false);

  void signIn() {
    if (fieldValidation()) {
      firebaseController.isLoginRequest = true;
      firebaseController.fbLogin(countryCodeController.text.toString() + mobileNumber.text.toString());
    }
  }

  bool fieldValidation() {
    return formKey.currentState?.validate() == true;
  }
}
